from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import permissions as drf_permissions
from rest_framework.pagination import PageNumberPagination
from django.shortcuts import get_object_or_404
from rest_framework.exceptions import NotAcceptable
from django.db.utils import IntegrityError
from drf_yasg.utils import swagger_auto_schema
from django.contrib.postgres.search import TrigramSimilarity
from django.apps import apps
from django.db.models import Q
from ..models import rank_tag
from drf_yasg import openapi
from .. import models
from .. import serializers
from .. import permissions

related_university = openapi.Parameter('related_university', openapi.IN_QUERY, description="University ID", type=openapi.TYPE_INTEGER)
related_program = openapi.Parameter('related_program', openapi.IN_QUERY, description="Program ID", type=openapi.TYPE_INTEGER)
result = openapi.Parameter('result', openapi.IN_QUERY, description="admissions result", type=openapi.TYPE_STRING)
enrolledSemester = openapi.Parameter('enrolledSemester', openapi.IN_QUERY, description="enrolledSemester", type=openapi.TYPE_STRING)
rank = openapi.Parameter('rank', openapi.IN_QUERY, description="rank包括其之前的", type=openapi.TYPE_STRING)
apply_for = openapi.Parameter('apply_for', openapi.IN_QUERY, description="apply_for", type=openapi.TYPE_STRING)
major = openapi.Parameter('major', openapi.IN_QUERY, description="major", type=openapi.TYPE_STRING)
tags = openapi.Parameter('tags', openapi.IN_QUERY, description="tags", type=openapi.TYPE_STRING)
user_response = openapi.Response('data', serializers.AdmissionNestedSerializers(many=True))
param = openapi.Parameter('action', openapi.IN_QUERY, description="是('upvote', 'downvote')中的一个", type=openapi.TYPE_STRING)

class AdmissionsViewSet(
    mixins.ListModelMixin,
    mixins.CreateModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    queryset = models.Admissions.objects.all()
    permission_classes = [permissions.IsOwnerOrReadOnly]
    ordering = ('-created_time')
    pagination_class = PageNumberPagination

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset()).order_by('-created_time')

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    def perform_create(self, serializer):
        try:
            serializer.save(related_user=self.request.user, related_background=self.request.user.background)
        except models.Background.DoesNotExist:
            raise NotAcceptable(detail="请先创建申请背景", code=status.HTTP_400_BAD_REQUEST)
        except IntegrityError:
            raise NotAcceptable(detail="不能重复填写录取信息哦", code=status.HTTP_400_BAD_REQUEST)
    
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else request.user.id
        result = self.queryset.filter(related_user__id=pk)
        serializer_class = self.get_serializer_class()
        many = not isinstance(result, models.Admissions)
        result = serializer_class(result, many=many).data
        data = {
            'user_detail': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )
    
    @swagger_auto_schema(manual_parameters=[related_program, related_university, result, apply_for, major, tags, rank, enrolledSemester], responses={200: user_response})
    @action(methods=['post'], detail=False, url_path='condition_query', url_name='condition_query')
    def condition_query(self, request, *args, **kwargs):
        kwargs = request.data
        admission_filter = ['related_university', 'result', 'enrolledSemester']
        query = Q()
        if 'tags' in kwargs:
            tags = kwargs['tags']
            query &= Q(related_background__tags__contains=tags)
        if 'rank' in kwargs:
            rank_dict = dict(zip(rank_tag, range(len(rank_tag))))
            rank_num = rank_dict[kwargs['rank']]
            rank_list = []
            for i in range(rank_num + 1):
                rank_list.append(rank_tag[i])
            query &= Q(related_background__rank__in=rank_list)
        if 'apply_for' in kwargs:
            query &= Q(related_background__apply_for=kwargs['apply_for'])
        if 'major' in kwargs:
            query &= Q(related_background__major=kwargs['major'])
        for tag in admission_filter:
            if tag in kwargs:
                query &= Q(**{tag: kwargs[tag]})
        if 'related_program' in kwargs:
            program = kwargs['related_program']
            result = models.Admissions.objects.annotate(similarity=
                    TrigramSimilarity('related_program__unaccent', program),
                ).filter(similarity__gt=0.1)
        else:
            result = self.queryset
        result = result.filter(query).select_related('related_university', 'related_background').order_by('-created_time')
        page = self.paginate_queryset(result)
        if page is not None:
            data = serializers.AdmissionNestedSerializers(page, many=True, context={'request': request}).data
            return self.get_paginated_response(data)
        else:
            data = serializers.AdmissionNestedSerializers(result, many=True, context={'request': request}).data
        return Response(
            status=status.HTTP_200_OK,
            data={
                'condition_query': data
            }
        )

    # !TODO: refractor
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
        
    def get_serializer_class(self):
        # for listing
        if self.request.method in drf_permissions.SAFE_METHODS:
            return serializers.AdmissionNestedSerializers
        return serializers.AdmissionsSerializer

    def get_serializer(self, *args, **kwargs):
        if isinstance(kwargs.get('data', {}), list):
                kwargs['many'] = True
        return super().get_serializer(*args, **kwargs)