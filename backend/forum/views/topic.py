from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from django.contrib.auth.models import Group
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from django.shortcuts import get_object_or_404
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from .. import models
from .. import serializers
from .. import permissions

param = openapi.Parameter('action', openapi.IN_QUERY, description="是('upvote', 'downvote', 'pin', 'unpin', 'follow', 'unfollow')中的一个", type=openapi.TYPE_STRING)

class TopicViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.TopicSerializer
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.Topic.objects.all()
    
    @swagger_auto_schema(operation_description="新增topic_revision并创建topic, 审核通过后才会展示, 需要topic的内容参数")
    def create(self, request, *args, **kwargs):
        # 新建topic -> 新建topic, topic_revision
        pk = getattr(request.data, 'related_topic', None)
        if pk is None:
            # new topic
            revision_number = 0
            topic_serializer = serializers.TopicSerializer(data={
                'action': models.Topic.DEFAULT,
                'is_valid': False,
                'view_count': 0,
                'related_user': request.user.id
            })
            topic_serializer.is_valid(raise_exception=True)
            topic = topic_serializer.save()
        else:
            topic = get_object_or_404(pk=pk)
            revision_set = models.Topic.objects.revision_set(pk=pk)
            revision_number = revision_set.latest().revision_number + 1
        topic_revision_serializer = serializers.TopicRevisionSerializer(data={
            'related_topic': topic.id,
            # 'related_user': self.request.user.id,
            'revision_number': revision_number,
            **request.data.dict()
        })
        topic_revision_serializer.is_valid(raise_exception=True)
        # ! TODO: clean content
        topic_revision = topic_revision_serializer.save(related_user=self.request.user)
        models.Notification.notify_group(topic_revision, topic.group, models.Notification.PR)
        return super().create(request, *args, **kwargs)
    
    # !TODO: test this api
    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)
    
    @swagger_auto_schema(manual_parameters=[param], responses={200: 'ok', 304: "action不存在"})
    @action(methods=['put'], detail=True, url_path='action', url_name='action')
    def action(self, request, pk=None, *args, **kwargs):
        topic = get_object_or_404(self.queryset, pk=pk)
        action = request.data['action']
        if action == 'upvote':
            topic.upvote(user=request.user)
        elif action == 'downvote':
            topic.downvote(user=request.user)
        elif action == 'pin':
            topic.pin()
        elif action == 'unpin':
            topic.unpin()
        elif action == 'follow':
            topic.follow(user=request.user)
        elif action == 'unfollow':
            topic.follow(user=request.user)
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

class TopicRevisionViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.TopicRevisionSerializer
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.TopicRevision.objects.all()
    
    @swagger_auto_schema(operation_description="如果是审核topic的内容则需要is_valid参数，否则不需要")
    def perform_update(self, serializer):
        topic_revision = serializer.save()
        if 'is_valid' in serializer.validated_data:
            is_valid = serializer.validated_data['is_valid']
            if is_valid:
                # 审核通过
                # !TODO: 不同版本的merge
                if models.Topic.set_valid_and_update(topic_revision.related_topic_id, topic_revision):
                    models.Notification.notify_group(topic_revision.related_topic, topic_revision.related_topic.followed, models.Notification.UPDATED)
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.APPROVED)
                
            elif not is_valid:
                # 审核未通过
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.REJECTED)