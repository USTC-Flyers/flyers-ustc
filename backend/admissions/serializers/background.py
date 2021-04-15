from rest_framework import serializers
from .. import models

class BackgroundSerializers(serializers.ModelSerializer):
    # researchTag = serializers.CharField(many=True)
    # referTag = serializers.CharField(many=True)
    # applyFor = serializers.CharField(many=True)
    class Meta:
        model = models.Background
        db_table = 't_background'
        fields = '__all__'
        lookup_field = 'id'