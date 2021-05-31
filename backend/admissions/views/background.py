from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from drf_yasg.utils import swagger_auto_schema
from django.shortcuts import get_object_or_404
from rest_framework.exceptions import NotAcceptable
from django.db.utils import IntegrityError
from django.apps import apps
from drf_yasg import openapi
from .. import permissions
from .. import models
from .. import serializers

param = openapi.Parameter('action', openapi.IN_QUERY, description="是('upvote', 'downvote')中的一个", type=openapi.TYPE_STRING)

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
        
    def perform_create(self, serializer):
        try:
            serializer.save(related_user=self.request.user)
        except IntegrityError:
            raise NotAcceptable(detail="不能重复创建申请背景哦", code=status.HTTP_400_BAD_REQUEST)
    
    @action(methods=['get'], detail=True, url_path='get_school', url_name='get_school')
    def get_school(self, request, pk=None, *args, **kwargs):
        return Response(
            data=models.school_list,
            status=status.HTTP_200_OK
        )
        
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else request.user.id
        result = get_object_or_404(self.queryset, related_user__id=pk)
        result = serializers.BackgroundSerializers(result, context={'request': request}).data
        data = {
            'user_detail': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )
        
    @swagger_auto_schema(manual_parameters=[param], responses={200: 'ok', 304: "action不存在"})
    @action(methods=['patch'], detail=True, url_path='action', url_name='action')
    def action(self, request, pk=None):
        model_notification = apps.get_model('forum.notification')
        bg = get_object_or_404(self.queryset, pk=pk)
        action = request.data['action']
        if action == 'upvote':
            bg.upvote(user=request.user)
            model_notification.notify(bg, to_user=bg.related_user, operation=model_notification.UPVOTED)
        elif action == 'downvote':
            bg.downvote(user=request.user)
        else:
            return Response(
                status=status.HTTP_304_NOT_MODIFIED,
                data={
                    'msg': 'action不存在',
                    'errono': -1
                }
            )
        return Response(
            status=status.HTTP_200_OK,
            data={
                    'msg': 'ok',
                    'errono': 0
                }
        )