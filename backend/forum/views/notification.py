from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from django.shortcuts import get_object_or_404
from rest_framework.pagination import PageNumberPagination
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
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.NotificationSerializer
    queryset = models.Notification.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    pagination_class = PageNumberPagination
    
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
    
    @swagger_auto_schema(responses={200: resp})
    @action(methods=['get'], detail=False, url_path='unread', url_name='unread')
    def unread(self, request, *args, **kwargs):
        result = models.Notification.objects.unread_set(user=request.user)
        serializer_class = self.get_serializer_class()
        many = not isinstance(result, models.Notification)
        result = serializer_class(result, many=many).data
        return Response(
            status=status.HTTP_200_OK,
            data={
                'msg': 'ok',
                'errno': 0,
                'unread': result
            }
        )