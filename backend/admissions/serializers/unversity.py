from rest_framework import serializers
from .. import models

class UniversitySerializer(serializers.ModelSerializer):
    class Meta:
        model = models.University
        db_table = 't_university'
        fields = '__all__'
        read_only_fields = ['area', 'school_name', 'school_name_cn', 'short_name']
        lookup_field = 'id'