from django.http import HttpResponse
from rest_framework import generics

from .models import Directory
from .serializers import DirectorySerializer, DirectoryVersionSerializer, DirectoryElementSerializer


def index(request):
    return HttpResponse("Страница приложения handbook")


# Представления для модели Словарь
class DirectoryAPIList(generics.ListCreateAPIView):
    """Получение списка справочников"""
    queryset = Directory.objects.all()
    serializer_class = DirectorySerializer


class DirectoryAPIUpdate(generics.RetrieveUpdateAPIView):
    """Позволяет изменять Справочник"""
    queryset = Directory.objects.all()
    serializer_class = DirectorySerializer


class DirectoryAPIDestroy(generics.RetrieveDestroyAPIView):
    """Позволяет удалять Справочник"""
    queryset = Directory.objects.all()
    serializer_class = DirectorySerializer


# Представления для модели версия справочника
class DirectoryVersionAPIList(generics.ListCreateAPIView):
    """Возвращает список версий справочника"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryVersionSerializer


class DirectoryVersionAPIUpdate(generics.RetrieveUpdateAPIView):
    """Позволяет изменять версий справочника"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryVersionSerializer


class DirectoryVersionAPIDestroy(generics.RetrieveDestroyAPIView):
    """Позволяет удалять версий справочника"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryVersionSerializer


# Представления для модели элемент справочника
class DirectoryElementAPIList(generics.ListCreateAPIView):
    """Возвращает список элементов справочника"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryElementSerializer


class DirectoryElementAPIUpdate(generics.RetrieveUpdateAPIView):
    """Позволяет изменять элемент справочника"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryElementSerializer


class DirectoryElementAPIDestroy(generics.RetrieveDestroyAPIView):
    """Позволяет элемент справочника"""
    queryset = Directory.objects.all()
    serializer_class = DirectoryElementSerializer
