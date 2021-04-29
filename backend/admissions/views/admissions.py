from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import permissions as drf_permissions
from django.shortcuts import get_object_or_404
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from .. import models
from .. import serializers
from .. import permissions

class AdmissionsViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    queryset = models.Admissions.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    ordering = ('-created_time')
    
    def perform_create(self, serializer):
        serializer.save(related_user=self.request.user, related_background=self.request.user.background)
    
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else None
        if pk == None:
            result = self.request.user.admissions.all()
        else:
            result = self.queryset.filter(related_user__id=pk)
        serializer_class = self.get_serializer_class()
        many = not isinstance(result, models.Admissions)
        result = serializer_class(result, many=many).data
        data = {
            'user_detail': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )
        
    @action(methods=['post'], detail=False, url_path='condition_query', url_name='condition_query')
    def condition_query(self, request, *args, **kwargs):
        result = models.Admissions.objects.condition(**request.data)
        data = serializers.AdmissionNestedSerializers(result, many=True).data
        return Response(
            status=status.HTTP_200_OK,
            data={
                'condition_query': data
            }
        )
        
    @action(methods=['post'], detail=False, url_path='join', url_name='join')
    def join_creation(self, request, pk=None, *args, **kwargs):
        serializer = serializers.AdmissionNestedSerializers(data=request.data, many=True)
        serializer.is_valid(raise_exception=True)
        admission = serializer.save()
        return Response(
            status=status.HTTP_201_CREATED,
            data={
                'admission': admission
            }
        )
        
    def get_serializer_class(self):
        # for listing
        if self.request.method in drf_permissions.SAFE_METHODS:
            return serializers.AdmissionNestedSerializers
        return serializers.AdmissionsSerializers

    def get_serializer(self, *args, **kwargs):
        if isinstance(kwargs.get('data', {}), list):
                kwargs['many'] = True
        return super().get_serializer(*args, **kwargs)