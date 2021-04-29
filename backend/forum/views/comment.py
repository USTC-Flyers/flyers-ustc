from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from .. import models
from .. import serializers
from .. import permissions

param = openapi.Parameter('action', openapi.IN_QUERY, description="是('upvote', 'downvote', 'pin', 'unpin')中的一个", type=openapi.TYPE_STRING)

class CommentThreadViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.CommentThreadSerializer
    queryset = models.CommentThread.objects.public()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    def perform_create(self, serializer):
        comment_thread = serializer.save(related_user=self.request.user, action=models.CommentThread.DEFAULT)
        comment_thread.related_topic.increase_comment_thread_count()
        models.Notification.notify_group(comment_thread, comment_thread.related_topic.followed.all(), models.Notification.REPLIED)
    
    def perform_destroy(self, instance):
        serializer = self.get_serializer(instance, action=models.CommentThread.CLOSED)
        instance = serializer.save()
        instance.related_topic.decrease_comment_thread_count()
        models.Notification.notify(instance, instance.related_user, models.Notification.DELETED)
    
    @swagger_auto_schema(manual_parameters=[param], responses={200: 'ok', 304: "action不存在"})
    @action(methods=['put'], detail=True, url_path='action', url_name='action')
    def action(self, request, pk=None, *args, **kwargs):
        comment = get_object_or_404(self.queryset, pk=pk)
        action = request.data['action']
        if action == 'upvote':
            comment.upvote(user=request.user)
            models.Notification.notify(comment, to_user=comment.related_user, operation=models.Notification.UPVOTED)
        elif action == 'downvote':
            comment.downvote(user=request.user)
        elif action == 'pin':
            comment.pin()
            models.Notification.notify(comment, to_user=comment.related_user, operation=models.Notification.PINNED)
        elif action == 'unpin':
            comment.unpin()
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
    
class CommentiewSet(    
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.CommentSerializer
    queryset = models.Comment.objects.public()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    def perform_create(self, serializer):
        comment = serializer.save(related_user=self.request.user, action=models.CommentThread.DEFAULT)
        to_user = comment.related_comment_thread.related_user
        models.Notification.notify(comment=comment, to_user=to_user, operation=models.Notification.REPLIED)
        # !TODO: 回复特定comment    
    
    @swagger_auto_schema(manual_parameters=[param], responses={200: 'ok', 304: "action不存在"})
    @action(methods=['put'], detail=True, url_path='action', url_name='action')
    def action(self, request, pk=None, *args, **kwargs):
        comment = get_object_or_404(self.queryset, pk=pk)
        action = request.data['action']
        if action == 'upvote':
            comment.upvote(user=request.user)
            models.Notification.notify(comment, to_user=comment.related_user, operation=models.Notification.UPVOTED)
        elif action == 'downvote':
            comment.downvote(user=request.user)
        elif action == 'pin':
            comment.pin()
            models.Notification.notify(comment, to_user=comment.related_user, operation=models.Notification.PINNED)
        elif action == 'unpin':
            comment.unpin()
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
        
    def perform_destroy(self, instance):
        serializer = self.get_serializer(instance, action=models.Comment.CLOSED)
        instance = serializer.save()
        models.Notification.notify(instance, instance.related_user, models.Notification.DELETED)