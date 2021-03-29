from rest_framework import serializers
from .. import models

class ProgramSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Program
        db_table = 't_program'
        fields = '__all__'
        read_only_fields = ['name', 'full_name']
        lookup_field = 'id'
        