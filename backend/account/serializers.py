from rest_framework import serializers
from django.apps import apps
from django.conf import settings
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth.models import update_last_login
from rest_framework_simplejwt.tokens import RefreshToken
import random
from . import models

class IUniversitySerializer(serializers.ModelSerializer):
    class Meta:
        model = apps.get_model('admissions.university')
        db_table = 't_iuniversity'
        fields = '__all__'
        read_only_fields = ['area', 'school_name', 'school_name_cn', 'short_name']
        lookup_field = 'id'

class UserProfileSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='userprofile.related_user')
    class Meta:
        model = models.UserProfile
        db_table = 't_user_profile'
        fields = '__all__'
        lookup_field = 'id'
        
class UserProfileNestedSerializer(serializers.ModelSerializer):
    all_votes_cnt = serializers.IntegerField(source='get_all_votes_cnt', read_only=True)
    final_university = IUniversitySerializer()
    class Meta:
        model = models.UserProfile
        db_table = 't_user_profile'
        fields = ['id', 'related_user', 'nickname', 'school', 'contact', 'is_verified', \
            'role', 'followed', 'enrolledYear', 'isUndergrad', 'final_university', \
            'final_program', 'university', 'all_votes_cnt']
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