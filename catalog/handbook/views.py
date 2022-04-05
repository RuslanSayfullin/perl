from django.http import HttpResponse
from rest_framework import generics

from .models import Directory
from .serializers import DirectorySerializer


def index(request):
    return HttpResponse("Страница приложения handbook")


class DirectoryAPIList(generics.ListCreateAPIView):
    """Возвращает список словарей"""
    queryset = Directory.objects.all()
    serializer_class = DirectorySerializer


class DirectoryAPIUpdate(generics.RetrieveUpdateAPIView):
    """Позволяет изменять словари"""
    queryset = Directory.objects.all()
    serializer_class = DirectorySerializer


class DirectoryAPIDestroy(generics.RetrieveDestroyAPIView):
    """Позволяет удалять словари"""
    queryset = Directory.objects.all()
    serializer_class = DirectorySerializer

