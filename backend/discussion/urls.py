from django.urls import path, include
from rest_framework_nested import routers

from . import views

app_name = 'discussion'

router = routers.SimpleRouter()
router.register('post', views.PostViewSet)
router.register('comment', views.CommentViewSet)

urlpatterns = [
    path('', include(router.urls))
]