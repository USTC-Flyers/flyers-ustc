from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.response import Response
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
    serializer_class = serializers.AdmissionsSerializers
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.Admissions.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    def create(self, request, *args, **kwargs):
        univeristy = get_object_or_404(models.University, pk=request.data['uid'])
        program = get_object_or_404(models.Program, pk=request.data['pid'])
        user = self.request.user
        request.data['related_university'] = univeristy
        request.data['related_program'] = program
        request.data['related_user'] = user
        return super().create(request, *args, **kwargs)
    
    @action(methods=['get'], detail=False, url_path='my', url_name='my')
    def my_admission(self, request, pk=None, *args, **kwargs):
        result = self.request.user.admissions.objects().all()
        result = serializers.AdmissionsSerializers(result, many=True).data
        data = {
            'data': result,
            'msg': 'ok',
            'errno': 0
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )