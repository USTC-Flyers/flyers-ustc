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
from ..models import Post

param = openapi.Parameter('action', openapi.IN_QUERY,
                          description="是('like','cancel_like')中的一个",
                          type=openapi.TYPE_STRING)
param_category = openapi.Parameter('old_category', openapi.IN_QUERY, description="被更改的类别名，如果为空 则为新增类别",
                                   type=openapi.TYPE_STRING)
param_category_new = openapi.Parameter('new_category', openapi.IN_QUERY, description="更改的类别名",
                                       type=openapi.TYPE_STRING)


class CommentViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.CommentSerializer
    queryset = models.Comment.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    pagination_class = PageNumberPagination

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(
            self.get_queryset().filter(related_post_id=request.query_params.get('post_id'),
                                       related_comment_id=None)).order_by('-created_time')
        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)

    @swagger_auto_schema(operation_description="新增评论")
    def create(self, request, *args, **kwargs):
        pk = request.data.get('id', None)
        comment_serializer = serializers.CommentSerializer(data={
            'related_post': request.data.get('post_id'),
            'related_comment': request.data.get('comment_id'),
            'content': request.data.get('content'),
            'like_count': 0,
        })
        if pk is None:
            comment_serializer.is_valid(raise_exception=True)
            comment = comment_serializer.save(related_user=request.user)
            comment.related_post.comment_count += 1
            comment.related_post.save()
            if comment.related_comment is not None:
                Notification.notify(comment.related_post, to_user=comment.related_comment.related_user,
                                    operation=Notification.COMMENT,
                                    message=f"您在帖子[{comment.related_post.title}]的评论被用户{request.user.userprofile.nickname}回复了")
            else:
                Notification.notify(comment.related_post, to_user=comment.related_post.related_user, operation=Notification.COMMENT,
                                    message=f"您的帖子[{comment.related_post.title}]被用户{request.user.userprofile.nickname}评论了")
        else:
            comment = get_object_or_404(models.Comment, pk=pk)
        return Response(
            status=status.HTTP_201_CREATED,
            data=serializers.CommentNestedSerializers(comment, context={'request': request}).data
        )

    def destroy(self, request, *args, **kwargs):
        return super().destroy(request, *args, **kwargs)

    @swagger_auto_schema(manual_parameters=[param], responses={200: 'ok', 304: "action不存在"})
    @action(methods=['patch'], detail=True, url_path='action', url_name='action')
    def action(self, request, pk=None, *args, **kwargs):
        comment = get_object_or_404(self.queryset, pk=pk)
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
                comment.like(user=request.user)
                Notification.notify(comment.related_post, to_user=comment.related_user, operation=Notification.COMMENT_LIKED,
                                    message=f"您在帖子[{comment.related_post.title}]的评论被用户{request.user.userprofile.nickname}喜欢了")
            elif action == 'cancel_like':
                comment.cancel_like(user=request.user)
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
            return serializers.CommentNestedSerializers
        return serializers.CommentSerializer

    def get_permissions(self):
        if self.basename == "action":
            permission_classes = [drf_permissions.IsAuthenticated]
        else:
            permission_classes = [permissions.IsOwnerOrReadOnly]
        return [permission() for permission in permission_classes]
