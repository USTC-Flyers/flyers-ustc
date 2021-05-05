from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import permissions as drf_permissions
from django.core.exceptions import ObjectDoesNotExist
from rest_framework_jwt.settings import api_settings
from django.shortcuts import get_object_or_404
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework_simplejwt.exceptions import InvalidToken, TokenError
from django.http import JsonResponse, HttpRequest, HttpResponse, HttpResponseRedirect
from rest_framework_simplejwt.views import TokenObtainPairView
from django.conf import settings
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from urllib import parse as urllib_parse
from django.contrib.auth.models import update_last_login
from . import models
from . import serializers
from . import permissions
from .models import User

class UserProfileViewSet(
    mixins.CreateModelMixin,
    mixins.RetrieveModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    queryset = models.UserProfile.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
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

class CASLoginView(TokenObtainPairView):
    def get(self, request):
        serializer = self.get_serializer(data=request.data)

        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])

        return Response(serializer.validated_data, status=status.HTTP_200_OK)