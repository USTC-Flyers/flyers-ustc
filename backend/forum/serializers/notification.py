from rest_framework import serializers
from .. import models

class NotificationSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='notification.related_user')
    class Meta:
        model = models.Notification
        db_table = 't_notification'
        fields = '__all__'
        lookup_field = 'id'
    
    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        request = self.context['request']
        if request.method == 'POST' and 'related_user' in request.data and request.data['related_user'] != request.user:
            if raise_exception:
                raise serializers.ValidationError({'related_user': 'only create model by oneself'})
            valid = False
        return valid