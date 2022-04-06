from rest_framework import serializers

from .models import Directory, DirectoryVersion, DirectoryElement


class DirectorySerializer(serializers.ModelSerializer):
    """Сериализатор для модели Справочник"""
    class Meta:
        model = Directory
        fields = ("short_title", "title", "description", "is_actual")


class DirectoryVersionSerializer(serializers.ModelSerializer):
    """Сериализатор для модели версия Справочника"""
    class Meta:
        model = DirectoryVersion
        fields = ("title", "started_at", "directory")


class DirectoryElementSerializer(serializers.ModelSerializer):
    """Сериализатор для модели элемент  Справочника"""
    class Meta:
        model = DirectoryElement
        fields = ("title", "description", "directory_version")

