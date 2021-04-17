from rest_framework import mixins, status, viewsets
from rest_framework.decorators import action
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from . import models
from . import serializers
from . import permissions

class UserProfileViewSet(
    mixins.CreateModelMixin,
    mixins.RetrieveModelMixin,
    mixins.DestroyModelMixin,
    mixins.UpdateModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.UserProfileSerializer
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.UserProfile.objects.all()
    permission_classes = [permissions.IsAdminOrReadOnly]
    
    def perform_create(self, serializer):
        serializer.save(related_user=self.request.user)
    
    @action(methods=['get'], detail=False, url_path='user_detail', url_name='user_detail')
    def user_detail(self, request, pk=None, *args, **kwargs):
        if pk == None:
            result = self.request.user.user_profile.all()
        else:
            result = self.queryset.filter(related_user__id=pk)
        data = serializers.UserProfileSerializer(result).data
        return Response(
            status=status.HTTP_200_OK,
            data={
                'user_detail': data
            }
        )
    
class UserViewSet(
    mixins.RetrieveModelMixin,
    viewsets.GenericViewSet
):
    serializer_class = serializers.UserSerializer
    authentication_classes = [JSONWebTokenAuthentication]
    queryset = models.User.objects.all()
    
    @action(methods=['get'], detail=True, url_path='is_admin', url_name='is_admin')
    def role(self, request, pk=None, *args, **kwargs):
        return Response(
            data={
                'msg': 'ok',
                'errno': 0,
                'role': request.user.is_admin
            },
            status=status.HTTP_200_OK
        )