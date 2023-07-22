from rest_framework import serializers
from .. import models
from django.apps import apps
from django.conf import settings
from .background import BackgroundSerializers
from django.core.exceptions import ObjectDoesNotExist
from .unversity import UniversitySerializer
from .program import ProgramSerializer
from .admissions import UserInfoSerializer

class ResearchSerializer(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='admissions.related_user')
    referTag = serializers.CharField(required=False)
    related_background = serializers.ReadOnlyField(source='admissions.related_background')
    upvoted = serializers.SerializerMethodField(read_only=True)
    
    class Meta:
        model = models.Research
        db_table = 't_research'
        fields = '__all__'
        lookup_field = 'id'
        
    def get_upvoted(self, obj):
        user = self.context['request'].user
        res = user in obj.upvoted.all()
        return res

    #!FIXME: override the default is_valid
    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        request = self.context['request']
        if request.method == 'POST' and 'related_user' in request.data and request.data['related_user'] != request.user.id:
            if raise_exception:
                raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
            valid = False
        if request.method == 'POST':
            try:
                b = request.user.background
            except ObjectDoesNotExist:
                if raise_exception:
                    raise serializers.ValidationError({'background': '请先创建申请背景'})
                valid = False
        return valid
    

# for nested creation
class ResearchNestedSerializers(serializers.ModelSerializer):
    related_university = UniversitySerializer()
    related_background = BackgroundSerializers()
    related_user = UserInfoSerializer()
    upvoted = serializers.SerializerMethodField(read_only=True)
    
    class Meta:
        model = models.Research
        db_table = 't_research'
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
    
    
    