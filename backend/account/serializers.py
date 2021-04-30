from rest_framework import serializers
from . import models
from django.apps import apps
from django.conf import settings
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import update_last_login
from rest_framework_simplejwt.tokens import RefreshToken
import random

class UserProfileSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='userprofile.related_user')
    class Meta:
        model = models.UserProfile
        db_table = 't_user_profile'
        fields = '__all__'
        lookup_field = 'id'
        
class UserProfileNestedSerializer(serializers.ModelSerializer):
    related_user = serializers.SlugRelatedField(
        slug_field="username",
        queryset=apps.get_model(settings.AUTH_USER_MODEL).objects.all(),
        many=False
    )
    class Meta:
        model = models.UserProfile
        db_table = 't_user_profile'
        fields = '__all__'
        lookup_field = 'id'
        
class UserSerializer(serializers.Serializer):
    class Meta:
        model = models.User
        db_table = 't_user'
        fields = '__all__'
        lookup_field = 'id'
        extra_kwargs = {'password': {'write_only': True}}

class TokenObtainPairWithoutPasswordSerializer(TokenObtainPairSerializer):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['password'].required = False
        self.fields['username'].required = False

    def validate(self, attrs):
        attrs.update({'password': '', 'username': "".join(random.choices('0123456789abcdefghijklmnopqrstuvwxyz@.+-_', k=10))})
        return super().validate(attrs)

    @classmethod
    def get_token(cls, user):
        return RefreshToken.for_user(user)