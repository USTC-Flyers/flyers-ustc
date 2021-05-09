from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from django.contrib.auth.models import Group
from django.shortcuts import get_object_or_404
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions as drf_permissions
from django.contrib.contenttypes.fields import GenericRelation
from drf_yasg import openapi
from django.conf import settings
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
    queryset = models.Topic.objects.public()
    
    def retrieve(self, request, *args, **kwargs):
        self.get_object().visit()
        return super().retrieve(request, *args, **kwargs)
    
    @swagger_auto_schema(operation_description="新增topic_revision并创建topic, 审核通过后才会展示, 需要topic的内容参数")
    def create(self, request, *args, **kwargs):
        # 新建topic -> 新建topic, topic_revision
        pk = request.data['related_topic'] if 'related_topic' in request.data else None
        if pk is None:
            # new topic
            revision_number = 0
            group_name = request.data['category']
            group = get_object_or_404(Group.objects.all(), name=group_name)
            topic_serializer = serializers.TopicSerializer(data={
                'action': models.Topic.DEFAULT,
                'is_valid': False,
                'view_count': 0,
                'related_user': request.user.id,
                'group': group.id
            })
            topic_serializer.is_valid(raise_exception=True)
            topic = topic_serializer.save()
        else:
            topic = get_object_or_404(models.Topic, pk=pk)
            revision_set = models.TopicRevision.objects.revision_set(pk=pk)
            revision_number = revision_set.latest().revision_number + 1
        topic_revision_serializer = serializers.TopicRevisionSerializer(data={
            'related_topic': topic.id,
            # 'related_user': self.request.user.id,
            'revision_number': revision_number,
            **request.data.dict(),
        })
        topic_revision_serializer.is_valid(raise_exception=True)
        # ! TODO: clean content
        topic_revision = topic_revision_serializer.save(related_user=self.request.user)
        topic.set_valid_and_update(topic_revision)
        models.Notification.notify_group(topic_revision, topic.group.user_set.all(), models.Notification.PR)
        return Response(
            status=status.HTTP_201_CREATED,
            data=topic_revision_serializer.data
        )
    
    # !TODO: test this api
    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)
    
    @action(methods=['get'], detail=False, url_path='get_meta_title', url_name='get_meta_title')
    def get_meta_title(self, request, *args, **kwargs):
        data = models.Topic.objects.meta()
        return Response(
            status=status.HTTP_200_OK,
            data={
                'title': data
            }
        )
    
    @action(methods=['get'], detail=False, url_path='follow', url_name='follow')
    def follow(self, request, *args, **kwargs):
        result = self.request.user.topic_followed_by.all()
        serializer_class = self.get_serializer_class()
        many = not isinstance(result, models.Topic)
        result = serializer_class(result, many=many).data
        data = {
            'follow': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )
    
    @swagger_auto_schema(manual_parameters=[param], responses={200: 'ok', 304: "action不存在"})
    @action(methods=['patch'], detail=True, url_path='action', url_name='action')
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
    def get_serializer_class(self):
        # for listing
        if self.request.method in drf_permissions.SAFE_METHODS:
            return serializers.TopicNestedSerializer
        return serializers.TopicSerializer

class TopicRevisionViewSet(
    mixins.ListModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.TopicRevisionSerializer
    queryset = models.TopicRevision.objects.all()
    
    @swagger_auto_schema(operation_description="如果是审核topic的内容则需要is_valid参数，否则不需要")
    def perform_update(self, serializer):
        topic_revision = serializer.save()
        if 'is_valid' in serializer.validated_data:
            is_valid = serializer.validated_data['is_valid']
            if is_valid:
                # 审核通过
                # !TODO: 不同版本的merge
                if topic_revision.related_topic.set_valid_and_update(topic_revision):
                    models.Notification.notify_group(topic_revision.related_topic, topic_revision.related_topic.followed.all(), models.Notification.UPDATED)
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.APPROVED)
                
            elif not is_valid:
                # 审核未通过
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.REJECTED)
    
    # !FIXME: not validated
    def get_permissions_class(self):
        if 'is_valid' in self.request.data:
            return [permissions.IsWikiOwnerOrCannotValidate()]
        return [permissions.IsOwnerOrReadOnly()]
    
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else None
        if pk == None:
            result = self.request.user.topic_revision_author.all()
        else:
            result = self.queryset.filter(related_user__id=pk)
        serializer_class = self.get_serializer_class()
        many = not isinstance(result, models.TopicRevision)
        result = serializer_class(result, many=many).data
        data = {
            'user_detail': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )