from rest_framework import serializers
from .. import models
from django.apps import apps
from django.conf import settings
from .background import BackgroundSerializers

class AdmissionsSerializers(serializers.ModelSerializer):
    related_user = serializers.ReadOnlyField(source='admission.related_user')
    referTag = serializers.CharField(required=False)
    def __init__(self, *args, **kwargs):
        many = kwargs.pop('many', True)
        super().__init__(many=many, *args, **kwargs)
        
    class Meta:
        model = models.Admissions
        db_table = 't_admissions'
        fields = '__all__'
        lookup_field = 'id'

# for nested creation
class AdmissionNestedSerializers(serializers.ModelSerializer):
    related_user = serializers.SlugRelatedField(
        slug_field="username",
        queryset=apps.get_model(settings.AUTH_USER_MODEL).objects.all(),
        many=False
    )
    related_university = serializers.SlugRelatedField(
        slug_field="short_name",
        queryset=models.University.objects.all(),
        many=False,
    )
    related_program = serializers.SlugRelatedField(
        slug_field="full_name",
        queryset=models.Program.objects.all()
    )
    related_background = BackgroundSerializers()

    class Meta:
        model = models.Admissions
        db_table = 't_admissions'
        fields = '__all__'
        lookup_field = 'id'
        depth = 1