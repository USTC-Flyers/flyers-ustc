from rest_framework import serializers
from .. import models

class AdmissionsSerializers(serializers.ModelSerializer):
    class Meta:
        model = models.Admissions
        db_table = 't_admissions'
        fields = '__all__'
        lookup_field = 'id'