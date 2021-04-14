from rest_framework import serializers
from . import models

class UserProfileSerializer(serializers.Serializer):
    related_user = serializers.ReadOnlyField(source='userprofile.related_user')
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