from django.http import HttpResponse
from rest_framework import generics

from .models import Directory
from .serializers import DirectorySerializer, DirectoryVersionSerializer, DirectoryElementSerializer


def index(request):
    return HttpResponse("Страница приложения handbook")


# Представления для модели Словарь
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


# Представления для модели версия справочника
class DirectoryVersionAPIList(generics.ListCreateAPIView):
    """Возвращает список словарей"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryVersionSerializer


class DirectoryVersionAPIUpdate(generics.RetrieveUpdateAPIView):
    """Позволяет изменять словари"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryVersionSerializer


class DirectoryVersionAPIDestroy(generics.RetrieveDestroyAPIView):
    """Позволяет удалять словари"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryVersionSerializer


# Представления для модели элемент справочника
class DirectoryElementAPIList(generics.ListCreateAPIView):
    """Возвращает список словарей"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryElementSerializer


class DirectoryElementAPIUpdate(generics.RetrieveUpdateAPIView):
    """Позволяет изменять словари"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryElementSerializer


class DirectoryElementAPIDestroy(generics.RetrieveDestroyAPIView):
    """Позволяет удалять словари"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryElementSerializer
