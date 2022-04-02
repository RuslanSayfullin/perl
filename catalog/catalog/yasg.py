from django.urls import path
import drf_yasg
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

"""настройка drf-yasg автодокументирование api django rest framework"""
schema_view = get_schema_view(
    openapi.Info(
        title='Python libs catalog',
        default_version='v1',
        description="Опсание сервиса терминологии и REST API",
        license=openapi.License(name="BSD License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,)

)

urlpatterns = [
    path('swagger(?P<format>\.json|\yaml)', schema_view.without_ui(cache_timeout=0), name='schema-json'),
    path('swagger/',  schema_view.without_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
    path('redoc/',  schema_view.without_ui('redoc', cache_timeout=0), name='schema-redoc'),
]