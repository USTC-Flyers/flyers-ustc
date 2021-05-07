from django.urls import path, re_path, include
from . import views
from rest_framework_nested import routers

app_name = 'forum'

router = routers.SimpleRouter()
router.register('comment_thread', views.CommentThreadViewSet)
router.register('comment', views.CommentiewSet)
router.register('topic', views.TopicViewSet)
router.register('topic_revision', views.TopicRevisionViewSet)
router.register('notification', views.NotificationViewSet, basename='Notification')

urlpatterns = [
    path('', include(router.urls))
]