from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from django.shortcuts import get_object_or_404
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from .. import models
from .. import serializers
from .. import permissions

resp = openapi.Response(
    description='unread_count',
    examples={
        'msg': 'ok',
        'errno': '0',
        'unread_count': "unread_count"
    }
)

class NotificationViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.NotificationSerializer
    queryset = models.Notification.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    def list(self, request, *args, **kwargs):
        models.Notification.objects.read(user=request.user)
        return super().list(request, *args, **kwargs)
    
    @swagger_auto_schema(responses={200: resp})
    @action(methods=['get'], detail=False, url_path='unread_count', url_name='unread_count')
    def unread_count(self, request, *args, **kwargs):
        cnt = models.Notification.objects.unread_count(user=request.user)
        return Response(
            status=status.HTTP_200_OK,
            data={
                'msg': 'ok',
                'errno': 0,
                'unread_count': cnt
            }
        )