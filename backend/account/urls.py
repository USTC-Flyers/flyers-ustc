from django.urls import path, re_path, include
from . import views
from rest_framework_nested import routers

app_name = 'account'

router = routers.SimpleRouter()
router.register('user', views.UserViewSet)
router.register('user_profile', views.UserProfileViewSet)

urlpatterns = [
    path('', include(router.urls))
]