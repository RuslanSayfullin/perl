from django.urls import path

from .views import *

urlpatterns = [
    path('', index),
    path('api/v1/directory/', DirectoryAPIList.as_view()),
    path('api/v1/directory/<int:pk>/', DirectoryAPIUpdate.as_view()),
    path('api/v1/directorydelete/<int:pk>/', DirectoryAPIDestroy.as_view()),


]
