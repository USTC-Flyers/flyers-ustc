from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.conf import settings
from django.core.cache import cache
from .models import User
from rest_framework.exceptions import APIException
class JWTCASAuthentication(JWTAuthentication):
    def get_user(self, validated_token):
        return super().get_user(validated_token)

    def authenticate(self, request, *args, **kwargs):
        header = self.get_header(request)
        ticket = request.GET.get('ticket', None)
        service = request.GET.get('service', settings.CAS_HOME_URL)
        mail = request.data.get("mail")
        verify_code = request.data.get("verify_code")
        if mail is not None and verify_code is not None:
            cache_key = f'verification_code_{mail}'
            cached_code = cache.get(cache_key)
            if cached_code:
                if cached_code == verify_code:
                    try:
                        user, created = User.verify_mail(mail)
                        token = TokenObtainPairSerializer.get_token(user)
                        token['new_user_created'] = created
                        cache.delete(cache_key)
                        return user
                    except Exception as e:
                        return None
                raise APIException(detail="验证码错误")
            raise APIException(detail="验证码已过期")
        if header is None and ticket is None:
            return None
        # authenticate with token
        if header is not None and ticket is None:
            raw_token = self.get_raw_token(header)
            if raw_token is None:
                return None
            validated_token = self.get_validated_token(raw_token)
            return self.get_user(validated_token), validated_token
        # authenticate with ticket
        if ticket is not None:
            try:
                user, created = User.verify(ticket, service)
            except User.DoesNotExist:
                # !TODO: comment in production
                # if ticket == 'fake-ticket':
                #     return User.objects.get(gid='test')
                # elif ticket == 'fake-ticket-admin':
                #     return User.objects.get(gid='admin')
                return None
            token = TokenObtainPairSerializer.get_token(user)
            token['new_user_created'] = created
            return user
