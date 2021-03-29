from rest_framework import serializers
from .. import models

class BackgroundSerializers(serializers.ModelSerializer):
    class Meta:
        model = models.Background
        db_table = 't_background'
        fields = '__all__'
        lookup_field = 'id'