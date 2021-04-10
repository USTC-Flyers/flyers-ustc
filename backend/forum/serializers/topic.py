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
        
class TopicSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Topic
        db_table = 't_topic'
        fields = '__all__'
        lookup_field = 'id'