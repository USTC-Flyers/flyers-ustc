from rest_framework import serializers
from .. import models

class BackgroundSerializers(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='background.related_user')
    upvoted = serializers.SerializerMethodField(read_only=True)
    
    class Meta:
        model = models.Background
        db_table = 't_background'
        fields = '__all__'
        lookup_field = 'id'
        
    def get_upvoted(self, obj):
        user = self.context['request'].user
        res = user in obj.upvoted.all()
        return res
        
    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        request = self.context['request']
        if request.method == 'POST' and 'related_user' in request.data and request.data['related_user'] != request.user.id:
            if raise_exception:
                raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
            valid = False
        return valid
    
class InternBackgroundSerializers(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='Iinternbackground.related_user')
    upvoted = serializers.SerializerMethodField(read_only=True)
    
    class Meta:
        model = models.InternBackground
        db_table = 't_internbackground'
        fields = '__all__'
        lookup_field = 'id'
        
    def get_upvoted(self, obj):
        user = self.context['request'].user
        res = user in obj.upvoted.all()
        return res