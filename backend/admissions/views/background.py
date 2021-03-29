from rest_framework import mixins, status, viewsets
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.response import Response
from django.contrib.postgres.search import SearchVector
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from .. import permissions
from .. import models
from .. import serializers

class BackgroundViewSet(
    mixins.RetrieveModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.AdmissionsSerializers
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.Admissions.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)