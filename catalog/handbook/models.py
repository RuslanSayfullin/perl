from django.contrib.auth.models import User
from django.db import models
from django.urls import reverse


class Directory(models.Model):
    """Сущность Справочник"""
    uuid = models.CharField(editable=False, unique=True, max_length=40, db_index=True)
    short_title = models.CharField(max_length=128, verbose_name="Короткое наименование")
    title = models.CharField(max_length=255, verbose_name="Наименование")
    description = models.TextField(null=True, blank=True, verbose_name="Описание")
    is_actual = models.BooleanField(verbose_name="Актуальность справочника", default=False)
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Дата создания справочника")
    updated_at = models.DateTimeField(auto_now=True, verbose_name="Дата изменения справочника")
    user = models.ForeignKey(User, verbose_name='Пользователь', on_delete=models.CASCADE)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('directory', kwargs={'directory_id': self.pk})

    class Meta:
        verbose_name = 'Справочник'
        verbose_name_plural = 'Справочники'
        ordering = ['uuid', 'title']


class DirectoryVersion(models.Model):
    """Версия справочника"""
    uuid = models.CharField(editable=False, unique=True, max_length=40, db_index=True)
    title = models.CharField(max_length=255, null=False, blank=False, verbose_name="Версия справочника")
    started_at = models.DateTimeField(auto_now_add=True, verbose_name="Дата начала действия справочника этой версии")
    directory = models.ForeignKey(Directory, verbose_name='Справочник', on_delete=models.CASCADE)
    user = models.ForeignKey(User, verbose_name='Пользователь', on_delete=models.CASCADE)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('directory', kwargs={'dir_version_id': self.pk})

    class Meta:
        verbose_name = 'Версия справочника'
        verbose_name_plural = 'Версий справочника'
        ordering = ['uuid', 'title']


class DirectoryElement(models.Model):
    """Элемент справочника"""
    uuid = models.CharField(editable=False, unique=True, max_length=40, db_index=True)
    directory_version = models.ForeignKey(Directory, verbose_name='Справочник версия', on_delete=models.CASCADE)
    title = models.CharField(max_length=255, null=False, blank=False, verbose_name="Элемент справочника")
    description = models.TextField(null=False, blank=False, verbose_name="Значение элемента")

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('directory', kwargs={'dir_element_id': self.pk})

    class Meta:
        verbose_name = 'Элемент справочника'
        verbose_name_plural = 'Элементы справочника'
        ordering = ['uuid', 'title']
