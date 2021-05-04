from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import permissions as drf_permissions
from rest_framework.pagination import PageNumberPagination
from rest_framework.exceptions import NotAcceptable
from django.shortcuts import get_object_or_404
from django.db.utils import IntegrityError
from drf_yasg.utils import swagger_auto_schema
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
    
    def perform_create(self, serializer):
        try:
            serializer.save(related_user=self.request.user, related_background=self.request.user.background)
        except IntegrityError:
            raise NotAcceptable(detail="不能重复填写录取信息哦", code=status.HTTP_400_BAD_REQUEST)
    
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, *args, **kwargs):
        pk = int(self.request.query_params['pk']) if 'pk' in self.request.query_params else None
        if pk == None:
            result = self.request.user.admissions.all()
        else:
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
        result = models.Admissions.objects.condition(**request.data)
        data = serializers.AdmissionNestedSerializers(result, many=True).data
        return Response(
            status=status.HTTP_200_OK,
            data={
                'condition_query': data
            }
        )
        
    @action(methods=['post'], detail=False, url_path='join', url_name='join')
    def join_creation(self, request, pk=None, *args, **kwargs):
        serializer = serializers.AdmissionNestedSerializers(data=request.data, many=True)
        serializer.is_valid(raise_exception=True)
        admission = serializer.save()
        return Response(
            status=status.HTTP_201_CREATED,
            data={
                'admission': admission
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