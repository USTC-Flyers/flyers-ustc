from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.conf import settings
from .models import User

class JWTCASAuthentication(JWTAuthentication):
    def get_user(self, validated_token):
        return super().get_user(validated_token)

    def authenticate(self, request, *args, **kwargs):
        header = self.get_header(request)
        ticket = request.GET.get('ticket', None)
        service = request.GET.get('service', settings.CAS_HOME_URL)
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
                print('get user', created)
            except User.DoesNotExist:
                # !TODO: comment in production
                if ticket == 'fake-ticket':
                    return User.objects.get(id='test')
                elif ticket == 'fake-ticket-admin':
                    return User.objects.get(id='admin')
                return None
            token = TokenObtainPairSerializer.get_token(user)
            token['new_user_created'] = created
            return user