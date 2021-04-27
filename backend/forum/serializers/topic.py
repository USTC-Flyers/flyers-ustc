from rest_framework import serializers
from .. import models

class TopicRevisionSerializer(serializers.ModelSerializer):
    # related_user = serializers.Field(required=False)
    related_user = serializers.ReadOnlyField(source='topic.related_user')
    class Meta:
        model = models.TopicRevision
        db_table = 't_topic_revision'
        fields = '__all__'
        lookup_field = 'id'
        
    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        if 'request' in self.context:
            request = self.context['request']
            if request.method == 'POST' and 'related_user' in request.data and request.data['related_user'] != request.user.id:
                if raise_exception:
                    raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
                valid = False
        return valid
        
class TopicSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Topic
        db_table = 't_topic'
        fields = '__all__'
        lookup_field = 'id'
        
    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        # !FIXME
        if 'request' in self.context:
            request = self.context['request']
            if request.method == 'POST' and 'related_user' in request.data and request.data['related_user'] != request.user.id:
                if raise_exception:
                    raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
                valid = False
        return valid

class TopicNestedSerializer(serializers.ModelSerializer):
    current_version = TopicRevisionSerializer()
    
    class Meta:
        model = models.Topic
        db_table = 't_topic'
        fields = '__all__'
        lookup_field = 'id'