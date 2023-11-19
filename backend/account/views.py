import random
import string
from rest_framework.exceptions import APIException
from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from django.shortcuts import redirect
from rest_framework.response import Response
from rest_framework import permissions as drf_permissions
from django.shortcuts import get_object_or_404
from rest_framework.permissions import AllowAny, IsAuthenticated
from rest_framework_simplejwt.exceptions import InvalidToken, TokenError
from rest_framework_simplejwt.views import TokenObtainPairView
from django.conf import settings
from django.core.mail import send_mail
from django.core.cache import cache

from account.models.user import User
from . import models
from rest_framework_simplejwt.tokens import RefreshToken, AccessToken
from . import serializers
from . import permissions
from .authentication import JWTCASAuthentication
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer


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
        pk = self.request.query_params['pk'] if 'pk' in self.request.query_params else request.user.id
        result = get_object_or_404(self.queryset, related_user__id=pk)
        serializer_class = self.get_serializer_class()
        # !TODO: check duplicate user profile
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
    
    @action(methods=['get'], detail=False, url_path='is_admin', url_name='is_admin')
    def role(self, request, pk=None, *args, **kwargs):
        return Response(
            data={
                'msg': 'ok',
                'errno': 0,
                'role': request.user.is_admin()
            },
            status=status.HTTP_200_OK
        )


class CASLoginView(TokenObtainPairView):
    authentication_classes = ()
    permission_classes = (AllowAny, )

    def get(self, request):
        if 'service' in request.query_params:
            if 'redirect' in request.query_params:
                return redirect(f"{settings.WEBPATH_PREFIX}?redirect={request.query_params['redirect']}&ticket={request.query_params['ticket']}")
            else:
                return redirect(f"{settings.WEBPATH_PREFIX}?ticket={request.query_params['ticket']}")
        serializer = self.get_serializer(data=request.data)
        
        try:
            serializer.is_valid(raise_exception=True)
        except TokenError as e:
            raise InvalidToken(e.args[0])
        return Response(serializer.validated_data, status=status.HTTP_200_OK)
    
    def get_permissions(self):
        if self.request.method == "GET":
            return [AllowAny()]
        return super().get_permissions()


class MailSendCodeView(TokenObtainPairView):
    authentication_classes = ()
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        try:
            mail = request.data.get("mail")
            valid_suffixes = ['ustc.edu.cn', 'mail.ustc.edu.cn']
            if not any(mail.endswith(suffix) for suffix in valid_suffixes):
              return Response(status=status.HTTP_400_BAD_REQUEST,data="请输入正确的教育邮箱")
            code = ''.join(random.choices(string.ascii_letters + string.digits, k=6))
            alive_mintues = 5
            cache_key = f'verification_code_{mail}'
            cache.set(cache_key, code, timeout=60 * alive_mintues)
            subject = '登录验证码'
            message = f'您的验证码是: {code},有效期为{alive_mintues}分钟'
            from_email = settings.EMAIL_HOST_USER
            recipient_list = [mail]
            send_mail(subject, message, from_email, recipient_list)
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            return Response(status=status.HTTP_400_BAD_REQUEST)


class MailLoginView(TokenObtainPairView):
    authentication_classes = ()
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        mail = request.data.get("mail")
        verify_code = request.data.get("verify_code")
        if (mail is None or verify_code is None):
            return Response(status=status.HTTP_400_BAD_REQUEST)
        serializer = self.get_serializer(data=request.data)
        try:
            serializer.is_valid(raise_exception=True)
        except Exception as e:
            if isinstance(e,APIException):
                return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR,data=e.detail)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR, data="登录异常")
        return Response(serializer.validated_data, status=status.HTTP_200_OK)


class CASLogoutView(TokenObtainPairView):
    authentication_classes = [JWTCASAuthentication]
    permission_classes = (IsAuthenticated, )

    def post(self, request, *args, **kwargs):
        try:
            refresh_token = request.data.get("refresh_token")
            if refresh_token:
                token = RefreshToken(refresh_token)
                token.blacklist()
            # !FIXME: remove access token backlisted
            # !TODO: add Redis for backlisted tokens
            access_token = request.data.get("access_token")
            if access_token:
                token = AccessToken(access_token)
                token.backlist()

            return Response(status=status.HTTP_205_RESET_CONTENT)
        except Exception as e:
            return Response(status=status.HTTP_400_BAD_REQUEST)