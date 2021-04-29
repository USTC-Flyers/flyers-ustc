from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from django.contrib.auth import authenticate
from rest_framework.response import Response
from django.contrib.postgres.search import SearchVector
from drf_yasg.utils import swagger_auto_schema
from django.shortcuts import get_object_or_404
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
    queryset = models.Background.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    def perform_create(self, serializer):
        serializer.save(related_user=self.request.user)
    
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
        
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else None
        if pk == None:
            result = get_object_or_404(self.queryset, related_user=self.request.user.id)
        else:
            result = self.queryset.filter(related_user__id=pk).get()
        result = serializers.BackgroundSerializers(result).data
        data = {
            'user_detail': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )