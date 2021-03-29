from rest_framework import mixins, status, viewsets
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.response import Response
from django.contrib.postgres.search import SearchVector
from drf_yasg.utils import swagger_auto_schema
from drf_yasg import openapi
from .. import models
from .. import serializers

test_param = openapi.Parameter('short_name', openapi.IN_QUERY, description="University short name", type=openapi.TYPE_STRING)
user_response = openapi.Response('data', serializers.ProgramSerializer(many=True))

class ProgramViewSet(
    mixins.ListModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.ProgramSerializer
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.Program.objects.all()
    
    @swagger_auto_schema(manual_parameters=[test_param], responses={200: user_response, 204: "请填写学校"})
    def list(self, request, *args, **kwargs):
        query = request.get('short_name', '')
        if query == '':
            return Response(
                data={
                    "errno": -1,
                    "msg": "请填写学校"
                },
                status=status.HTTP_204_NO_CONTENT
            )
        else:
            # !FIXME: assert the queryset just contains a single element
            result = models.University.objects.filter(short_name__search=query).get()
            programs = self.queryset.filter(related_university=result)
            programs = serializers.ProgramSerializer(programs, many=True).data
            data = {
                "errno": 0,
                "msg": "ok",
                "data": programs
            }
            return Response(
                data=data,
                status=status.HTTP_200_OK
            )