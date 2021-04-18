from rest_framework import serializers
from . import models
from django.apps import apps
from django.conf import settings

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