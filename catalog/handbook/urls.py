from django.urls import path

from .views import *

urlpatterns = [
    path('', index),
    path('api/v1/directory/', DirectoryAPIList.as_view()),  # Получение списка справочников



    path('api/v1/directory/<int:pk>/', DirectoryAPIUpdate.as_view()),
    path('api/v1/directorydelete/<int:pk>/', DirectoryAPIDestroy.as_view()),
    path('api/v1/directoryver/', DirectoryVersionAPIList.as_view()),
    path('api/v1/directoryver/<int:pk>/', DirectoryVersionAPIUpdate.as_view()),
    path('api/v1/directoryverdelete/<int:pk>/', DirectoryVersionAPIDestroy.as_view()),
    path('api/v1/directoryelement/', DirectoryElementAPIList.as_view()),
    path('api/v1/directoryelement/<int:pk>/', DirectoryElementAPIUpdate.as_view()),
    path('api/v1/directoryelementdelete/<int:pk>/', DirectoryElementAPIDestroy.as_view()),
]
