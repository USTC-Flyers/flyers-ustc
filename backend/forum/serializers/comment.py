from rest_framework import serializers
from .. import models

class CommentSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='comment.related_user')
    class Meta:
        model = models.Comment
        db_table = 't_comment'
        fields = '__all__'
        lookup_field = 'id'
        
    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        request = self.context['request']
        if request.method == 'POST' and 'related_user' in request.data and request.data['related_user'] != request.user.id:
            if raise_exception:
                raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
            valid = False
        return valid
        
class CommentThreadSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='commentthread.related_user')
    class Meta:
        model = models.CommentThread
        db_table = 't_comment_thread'
        fields = '__all__'
        lookup_field = 'id'
        
    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        request = self.context['request']
        if request.method == 'POST' and 'related_user' in request.data and request.data['related_user'] != request.user.id:
            if raise_exception:
                raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
            valid = False
        return valid