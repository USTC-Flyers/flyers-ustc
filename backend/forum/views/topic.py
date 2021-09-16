from django.db.utils import IntegrityError
from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from django.contrib.auth.models import Group
from django.shortcuts import get_object_or_404
from drf_yasg.utils import swagger_auto_schema
from rest_framework import permissions as drf_permissions
from django.contrib.contenttypes.fields import GenericRelation
from django.db.utils import IntegrityError
from drf_yasg import openapi
from django.conf import settings
from .. import models
from .. import serializers
from .. import permissions

param = openapi.Parameter('action', openapi.IN_QUERY, description="是('upvote', 'downvote', 'pin', 'unpin', 'follow', 'unfollow')中的一个", type=openapi.TYPE_STRING)
param_category = openapi.Parameter('old_category', openapi.IN_QUERY, description="被更改的类别名，如果为空 则为新增类别", type=openapi.TYPE_STRING)
param_category_new = openapi.Parameter('new_category', openapi.IN_QUERY, description="更改的类别名", type=openapi.TYPE_STRING)

class TopicViewSet(
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
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
        pk = request.data.get('related_topic', None)
        if pk is None:
            # new topic
            revision_number = 0
            group_name = request.data['category']
            group = get_object_or_404(Group.objects.all(), name=group_name)
            topic_serializer = serializers.TopicSerializer(data={
                'action': models.Topic.DEFAULT,
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
            **request.data,
        })
        topic_revision_serializer.is_valid(raise_exception=True)
        # ! TODO: clean contents
        topic_revision = topic_revision_serializer.save(related_user=self.request.user)
        # 管理员自动更新
        if self.request.user.is_admin():
            if not topic.set_valid_and_update(topic_revision):
                return Response(
                    status=status.HTTP_400_BAD_REQUEST,
                    data={
                        "detail": "未成功更新"
                    }
                )
            models.Notification.notify_group(topic_revision.related_topic, topic_revision.related_topic.followed.all(), models.Notification.UPDATED)
        else:
            # 通知审核
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
        
    @action(methods=['get'], detail=False, url_path='get_category', url_name='get_category')
    def get_category(self, request):
        groups = Group.objects.all()
        group_name = []
        for group in groups:
            if group.name == 'flyers-admin':
                continue
            group_name.append(group.name)
        return Response(
            status=status.HTTP_200_OK,
            data={
                'category': group_name
            }
        )
    
    @swagger_auto_schema(method='patch', manual_parameters=[param_category, param_category_new], responses={'200': '更改成功', '201': '新建成功'})
    @action(methods=['patch'], detail=False, url_path='change_category', url_name='change_category') 
    def change_category(self, request):
        old_name = request.data.get('old_category', None)
        new_name = request.data['new_category']
        if old_name is None:
            group = Group.objects.create(name=new_name)
            group.save()
            return Response(
                status=status.HTTP_201_CREATED
            )
        else:
            group = get_object_or_404(Group.objects.all(), name=old_name)
            group.name = new_name
            group.save()
            return Response(
                status=status.HTTP_200_OK
            )
    
    @action(methods=['get'], detail=False, url_path='follow', url_name='follow')
    def follow(self, request, *args, **kwargs):
        result = self.request.user.topic_followed_by.all()
        serializer_class = self.get_serializer_class()
        many = not isinstance(result, models.Topic)
        result = serializer_class(result, many=many, context={'request': request}).data
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
        action = request.data.get('action', None)
        if action is None:
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={
                    'msg': 'action不存在',
                }
            )
        try:
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
                topic.unfollow(user=request.user)
            else:
                return Response(
                    status=status.HTTP_304_NOT_MODIFIED,
                    data={
                        'msg': 'action不存在',
                        'errono': -1
                    }
                )
        except IntegrityError:
            return Response(
                    status=status.HTTP_400_BAD_REQUEST,
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

    def get_permissions(self):
        if self.basename == "change_category" or self.basename == "review" or self.action == "destroy": 
            permission_classes = [permissions.IsWikiOwnerOrCannotValidate]
        elif self.basename == "action":
            permission_classes = [drf_permissions.IsAuthenticated]
        else:
            permission_classes = [permissions.IsOwnerOrReadOnly]
        return [permission() for permission in permission_classes]

class TopicRevisionViewSet(
    mixins.ListModelMixin,
    mixins.DestroyModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.TopicRevisionSerializer
    queryset = models.TopicRevision.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    
    @swagger_auto_schema(operation_description="如果是审核topic的内容则需要status参数，否则不需要")
    @action(methods=['patch'], detail=True, url_path='review', url_name='review')
    def review(self, request, pk):
        topic_revision = get_object_or_404(self.queryset, pk=pk)
        st = request.data.get("status",None)
        if st is not None:
            if st == models.TopicRevision.REVIEWAP and topic_revision.related_topic.set_valid_and_update(topic_revision):
                # 审核通过
                # !TODO: 不同版本的merge
                models.Notification.notify_group(topic_revision.related_topic, topic_revision.related_topic.followed.all(), models.Notification.UPDATED)
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.APPROVED)   
            elif st == models.TopicRevision.REVIEWREJ:
                # 审核未通过
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.REJECTED)
            else:
                return Response(status=status.HTTP_404_NO_CONTENT, data={"detail": "未更新成功"})
        return Response(status=status.HTTP_200_OK)
    # !FIXME: TEST
    def get_permissions_class(self):
        if 'status' in self.request.data or self.basename == "review":
            return [permissions.IsWikiOwnerOrCannotValidate()]
        return [permissions.IsOwnerOrReadOnly()]
    
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else request.user.id
        result = self.queryset.filter(related_user__id=pk)
        serializer_class = self.get_serializer_class()
        many = not isinstance(result, models.TopicRevision)
        result = serializer_class(result, many=many, context={'request': request}).data
        data = {
            'user_detail': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )