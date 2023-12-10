import base64
import hmac
import json
import time
import uuid
from datetime import datetime
from hashlib import sha1

from django.conf import settings
from django.contrib.auth.models import Group
from django.db.utils import IntegrityError
from django.shortcuts import get_object_or_404
from drf_yasg import openapi
from drf_yasg.utils import swagger_auto_schema
from rest_framework import mixins, status, viewsets
from rest_framework import permissions as drf_permissions
from rest_framework.decorators import action
from rest_framework.pagination import PageNumberPagination
from rest_framework.response import Response

from .. import models
from .. import permissions
from .. import serializers
from forum.models import Notification

param = openapi.Parameter('action', openapi.IN_QUERY,
                          description="是('like')中的一个",
                          type=openapi.TYPE_STRING)
param_category = openapi.Parameter('old_category', openapi.IN_QUERY, description="被更改的类别名，如果为空 则为新增类别",
                                   type=openapi.TYPE_STRING)
param_category_new = openapi.Parameter('new_category', openapi.IN_QUERY, description="更改的类别名",
                                       type=openapi.TYPE_STRING)


class PostViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.PostSerializer
    queryset = models.Post.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    pagination_class = PageNumberPagination

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset()).order_by('-created_time')

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    def retrieve(self, request, *args, **kwargs):
        self.get_object().visit()
        return super().retrieve(request, *args, **kwargs)

    @swagger_auto_schema(operation_description="新增帖子")
    def create(self, request, *args, **kwargs):
        pk = request.data.get('post_id', None)
        if pk is None:
            post_serializer = serializers.PostSerializer(data={
                'title': request.data.get('title'),
                'content': request.data.get('content'),
                'images': request.data.get('images'),
                'visit_count': 0,
                'like_count': 0,
                'comment_count': 0,
            })
            post_serializer.is_valid(raise_exception=True)
            post = post_serializer.save(related_user=self.request.user)
        else:
            post = get_object_or_404(models.Post, pk=pk)
        return Response(
            status=status.HTTP_201_CREATED,
        )


    @action(methods=['patch'], detail=True, url_path='review', url_name='review')
    def review(self, request, pk):
        topic_revision = get_object_or_404(self.queryset, pk=pk)
        st = request.data.get("status", None)
        if st is not None:
            if st == models.TopicRevision.REVIEWAP and topic_revision.related_topic.set_valid_and_update(
                    topic_revision):
                # 审核通过
                # !TODO: 不同版本的merge
                models.Notification.notify_group(topic_revision.related_topic,
                                                 topic_revision.related_topic.followed.all(),
                                                 models.Notification.UPDATED)
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.APPROVED)
            elif st == models.TopicRevision.REVIEWREJ:
                # 审核未通过
                models.Notification.notify(topic_revision, topic_revision.related_user, models.Notification.REJECTED)
            else:
                return Response(status=status.HTTP_404_NO_CONTENT, data={"detail": "未更新成功"})
        return Response(status=status.HTTP_200_OK)

    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)

    @action(methods=['get'], detail=False, url_path='upload_img', url_name='upload_img')
    def upload_img(self, request, *args, **kwargs):
        policy_dict = {}
        expire_timestamp = int(time.time()) + 60 * 60
        expiration = f'{datetime.utcfromtimestamp(expire_timestamp).isoformat()}Z'
        key = 'images/' + str(uuid.uuid4())
        content_disposition = 'inline;filename="' + key + '"'
        policy_dict['expiration'] = expiration
        policy_dict['conditions'] = [["eq", "$success_action_status", "201"],
                                     ["eq", "$content-disposition", content_disposition], ["eq", "$key", key]]
        policy = json.dumps(policy_dict).strip()
        policy_encode = base64.b64encode(policy.encode())
        h = hmac.new(settings.OSS_ACCESS_KEY_SECRET.encode(), policy_encode, sha1)
        sign_result = base64.encodebytes(h.digest()).strip()
        form_data = {}
        form_data['OSSAccessKeyId'] = settings.OSS_ACCESS_KEY_ID
        form_data['host'] = settings.OSS_ENDPOINT
        form_data['policy'] = policy_encode.decode()
        form_data['signature'] = sign_result.decode()
        form_data['expire'] = expiration
        form_data['Content-Disposition'] = content_disposition
        form_data['key'] = key
        return Response(
            status=status.HTTP_201_CREATED,
            data=form_data
        )

    @swagger_auto_schema(manual_parameters=[param], responses={200: 'ok', 304: "action不存在"})
    @action(methods=['patch'], detail=True, url_path='action', url_name='action')
    def action(self, request, pk=None, *args, **kwargs):
        post = get_object_or_404(self.queryset, pk=pk)
        action = request.data.get('action', None)
        if action is None:
            return Response(
                status=status.HTTP_404_NOT_FOUND,
                data={
                    'msg': 'action不存在',
                }
            )
        try:
            if action == 'like':
                post.like(user=request.user)
                Notification.notify(post, to_user=post.related_user, operation=Notification.LIKED,
                                    message=f"您的帖子[{post.title}]被用户{request.user.userprofile.nickname}喜欢了")
            elif action == 'cancel_like':
                post.cancel_like(user=request.user)
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
        if self.request.method in drf_permissions.SAFE_METHODS:
            return serializers.PostNestedSerializers
        return serializers.PostSerializer

    def get_permissions(self):
        if self.basename == "action":
            permission_classes = [drf_permissions.IsAuthenticated]
        else:
            permission_classes = [permissions.IsOwnerOrReadOnly]
        return [permission() for permission in permission_classes]
