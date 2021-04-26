from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.response import Response
from rest_framework import permissions as drf_permissions
from django.core.exceptions import ObjectDoesNotExist
from rest_framework_jwt.settings import api_settings
from django_cas_ng import views as cas_views
from django.shortcuts import get_object_or_404
from django_cas_ng.models import ProxyGrantingTicket, SessionTicket
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from django_cas_ng.utils import get_protocol, get_redirect_url, get_cas_client
from django_cas_ng.signals import cas_user_logout
from django.http import JsonResponse, HttpRequest, HttpResponse, HttpResponseRedirect
from django.conf import settings
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from urllib import parse as urllib_parse
from django.contrib.auth.models import update_last_login
from . import models
from . import serializers
from . import permissions
from .models import User

JWT_PAYLOAD_HANDLER = api_settings.JWT_PAYLOAD_HANDLER
JWT_ENCODE_HANDLER = api_settings.JWT_ENCODE_HANDLER

class UserProfileViewSet(
    mixins.CreateModelMixin,
    mixins.RetrieveModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.UserProfile.objects.all()
    permission_classes = [permissions.IsAdminOrReadOnly]
    
    def perform_create(self, serializer):
        serializer.save(related_user=self.request.user)
    
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else None
        try:
            if pk == None:
                result = self.request.user.userprofile
            else:
                result = self.queryset.filter(related_user__id=pk).get()
        except ObjectDoesNotExist:
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={
                    "msg": "未创建申请背景",
                    "errono": -1
                }
            )
        
        serializer_class = self.get_serializer_class()
        data = serializer_class(result).data
        return Response(
            status=status.HTTP_200_OK,
            data={
                'user_detail': data
            }
        )
    
    def get_serializer_class(self):
        # for listing
        if self.request.method in drf_permissions.SAFE_METHODS:
            return serializers.UserProfileNestedSerializer
        return serializers.UserProfileSerializer
    
class UserViewSet(
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.UserSerializer
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.User.objects.all()
    
    @action(methods=['get'], detail=True, url_path='is_admin', url_name='is_admin')
    def role(self, request, pk=None, *args, **kwargs):
        return Response(
            data={
                'msg': 'ok',
                'errno': 0,
                'role': request.user.is_admin
            },
            status=status.HTTP_200_OK
        )
    
@api_view() 
@permission_classes([AllowAny])
def get_token(request, *args, **kwargs):
    try:
        ticket = request.GET.get('ticket')
        service = request.GET.get('service', 'http://home.ustc.edu.cn/~kelleykuang/cas/index.html?id=null')
        user, created = User.verify(ticket, service)
        payload = JWT_PAYLOAD_HANDLER(user)
        jwt_token = JWT_ENCODE_HANDLER(payload)
        update_last_login(None, user)
    except User.DoesNotExist:
        return Response(
            status=status.HTTP_403_FORBIDDEN
        )
    return Response(
        status=status.HTTP_200_OK if not created else status.HTTP_201_CREATED,
        data={
            'token': jwt_token
        }
    )

# for djang-cas-ng
class APILoginView(cas_views.LoginView):
    def successful_login(self, request, next_page):
        try:
            user = User.objects.get(id=request.user.id)
        except User.DoesNotExist:
            user = request.user

        # create jwt token
        payload = JWT_PAYLOAD_HANDLER(user)
        jwt_token = JWT_ENCODE_HANDLER(payload)
        update_last_login(None, user)

        new_next_page = settings.SUCCESS_SSO_AUTH_REDIRECT + 'login/' + jwt_token 
        return HttpResponseRedirect(new_next_page)
    
class APILogoutView(cas_views.LogoutView):
    def get(self, request):
        next_page = settings.SUCCESS_SSO_AUTH_REDIRECT

        # try to find the ticket matching current session for logout signal
        try:
            st = SessionTicket.objects.get(session_key=request.session.session_key)
            ticket = st.ticket
        except SessionTicket.DoesNotExist:
            ticket = None
        # send logout signal
        cas_user_logout.send(
            sender="manual",
            user=request.user,
            session=request.session,
            ticket=ticket,
        )

        # clean current session ProxyGrantingTicket and SessionTicket
        ProxyGrantingTicket.objects.filter(session_key=request.session.session_key).delete()
        SessionTicket.objects.filter(session_key=request.session.session_key).delete()
        auth_logout(request)

        next_page = next_page or get_redirect_url(request)
        if settings.CAS_LOGOUT_COMPLETELY:
            client = get_cas_client(request=request)
            return HttpResponseRedirect(client.get_logout_url(next_page))