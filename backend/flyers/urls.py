"""flyers URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, re_path, include
from rest_framework import permissions
from rest_framework_jwt.views import obtain_jwt_token
from drf_yasg.views import get_schema_view
from drf_yasg import openapi
import django_cas_ng.views
from django.conf import settings
from account.views import get_token
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)
urlpatterns = [
    path('admin/', admin.site.urls),
]

schema_view = get_schema_view(
   openapi.Info(
      title="Flyers API",
      default_version='v1',
      description="Flyers api description placeholder",
      terms_of_service="http://www.placeholder.com/",
      contact=openapi.Contact(email="contact@ustc.edu.cn"),
      license=openapi.License(name="BSD License"),
   ),
   public=True,
   permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    re_path('api/swagger(?P<format>\.json|\.yaml)', schema_view.without_ui(cache_timeout=0), name='schema-json'),
    path('api/swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('api/redoc/', schema_view.with_ui('redoc', cache_timeout=0), name='schema-redoc'),
    path('api/admin/', admin.site.urls),
    path('api/api-auth/', include('rest_framework.urls')),
    path('api/', include('admissions.urls')),  
    path('api/', include('forum.urls')),      
    path('api/', include('account.urls'))
]

if settings.DEBUG:
    urlpatterns.append(path('api/get_token/', get_token))
    # urlpatterns.append(path('api/login/', TokenObtainPairView.as_view()))
    # urlpatterns.append(path('api/login/refresh/', TokenRefreshView.as_view(), name='token_refresh'),)
else:
    urlpatterns.append(path('api/login', django_cas_ng.views.LoginView.as_view(), name='cas_ng_login'))
    urlpatterns.append(path('api/logout', django_cas_ng.views.LogoutView.as_view(), name='cas_ng_logout'))