from django.urls import path, re_path

from .views import *

urlpatterns = [
    path('', index),
    path('api/v1/directory/', DirectoryAPIList.as_view()),  # Получение списка справочников
    re_path(r'^api/v1/directory/(?P<year>[0-9]{4})-(?P<month>[0-9]{2})-(?P<day>[0-9]{2})/',
            DirectoryActualAPIList.as_view()),  # Получение списка справочников, актуальных на указанную дату



    # path('api/v1/directory/<int:pk>/', DirectoryAPIUpdate.as_view()),
    # path('api/v1/directorydelete/<int:pk>/', DirectoryAPIDestroy.as_view()),
    # path('api/v1/directoryver/', DirectoryVersionAPIList.as_view()),
    # path('api/v1/directoryver/<int:pk>/', DirectoryVersionAPIUpdate.as_view()),
    # path('api/v1/directoryverdelete/<int:pk>/', DirectoryVersionAPIDestroy.as_view()),
    # path('api/v1/directoryelement/', DirectoryElementAPIList.as_view()),
    # path('api/v1/directoryelement/<int:pk>/', DirectoryElementAPIUpdate.as_view()),
    # path('api/v1/directoryelementdelete/<int:pk>/', DirectoryElementAPIDestroy.as_view()),
]
