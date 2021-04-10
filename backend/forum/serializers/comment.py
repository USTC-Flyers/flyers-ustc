from rest_framework import serializers
from .. import models

class CommentSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='comment.related_user')
    class Meta:
        model = models.Comment
        db_table = 't_comment'
        fields = '__all__'
        lookup_field = 'id'
        
class CommentThreadSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='commentthread.related_user')
    class Meta:
        model = models.CommentThread
        db_table = 't_comment_thread'
        fields = '__all__'
        lookup_field = 'id'