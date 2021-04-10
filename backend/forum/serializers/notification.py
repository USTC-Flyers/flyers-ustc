from rest_framework import serializers
from .. import models

class NotificationSerializer(serializers.ModelSerializer):
    related_user = serializers.Field(required=False)
    class Meta:
        model = models.Notification
        db_table = 't_notification'
        fields = '__all__'
        lookup_field = 'id'