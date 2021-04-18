from rest_framework import serializers
from .. import models
from django.apps import apps
from django.conf import settings
from .background import BackgroundSerializers
from django.core.exceptions import ObjectDoesNotExist

class AdmissionsSerializers(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='admissions.related_user')
    referTag = serializers.CharField(required=False)
    related_background = serializers.ReadOnlyField(source='admissions.related_background')
        
    class Meta:
        model = models.Admissions
        db_table = 't_admissions'
        fields = '__all__'
        lookup_field = 'id'
        
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
class AdmissionNestedSerializers(serializers.ModelSerializer):
    related_university = serializers.SlugRelatedField(
        slug_field="short_name",
        queryset=models.University.objects.all(),
        many=False,
    )
    related_program = serializers.SlugRelatedField(
        slug_field="name",
        queryset=models.Program.objects.all()
    )
    related_background = BackgroundSerializers()

    class Meta:
        model = models.Admissions
        db_table = 't_admissions'
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