from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
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
    serializer_class = serializers.BackgroundSerializers
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.Background.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    def get_serializer(self, *args, **kwargs):
        if self.request.method in ['PUT', 'POST']:
            data = self.request.data.copy()
            data['related_user'] = self.request.user.id
            kwargs["data"] = data
        return super().get_serializer(*args, **kwargs)
    
    @action(methods=['get'], detail=True, url_path='get_major', url_name='get_major')
    def get_major(self, request, pk=None, *args, **kwargs):
        return Response(
            data=models.major,
            status=status.HTTP_200_OK
        )
    
    @action(methods=['get'], detail=True, url_path='get_school', url_name='get_school')
    def get_school(self, request, pk=None, *args, **kwargs):
        return Response(
            data=models.school_list,
            status=status.HTTP_200_OK
        )