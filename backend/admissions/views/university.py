from rest_framework import mixins, status, viewsets
from rest_framework.response import Response
from django.contrib.postgres.search import SearchVector, TrigramSimilarity
from django.db.models.functions import Greatest
from drf_yasg.utils import swagger_auto_schema
from django.db.models import Q
from drf_yasg import openapi
from .. import models
from .. import serializers

parmas = openapi.Parameter('query', openapi.IN_QUERY, description="Type in query", type=openapi.TYPE_STRING)
response = openapi.Response('data', serializers.UniversitySerializer(many=True))

class UniversityViewSet(
    mixins.ListModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.UniversitySerializer
    queryset = models.University.objects.all()
    
    @swagger_auto_schema(manual_parameters=[parmas], responses={200: ''})
    def list(self, request, *args, **kwargs):
        query = request.GET.get('query', '')
        result = models.University.objects.annotate(
            search=SearchVector('school_name', 'area', 'school_name_cn', 'short_name'),
        ).filter(search=query)
        if query != '' and result.count() == 0:
            result = models.University.objects.annotate(similarity=Greatest(
                TrigramSimilarity('short_name__unaccent', query),
                TrigramSimilarity('school_name__unaccent', query),
            )).filter(similarity__gt=0.3)
        result = serializers.UniversitySerializer(result, many=True).data
        data = {
            'msg': 'ok', 
            'errno': '0',
            'data': result
        }
        return Response(
            data=data,
            status=status.HTTP_200_OK
        )