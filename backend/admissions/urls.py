from django.urls import path, re_path, include
from . import views
from rest_framework_nested import routers

app_name = 'admissions'

router = routers.SimpleRouter()
router.register('program', views.ProgramViewSet)
router.register('university', views.UniversityViewSet)

urlpatterns = [
    path('', include(router.urls))
]