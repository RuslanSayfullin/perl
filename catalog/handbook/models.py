from django.contrib.auth.models import User
from django.db import models
from django.urls import reverse


class Directory(models.Model):
    """Сущность Справочник"""
    short_title = models.CharField(max_length=128, verbose_name="Короткое наименование")
    title = models.CharField(max_length=255, verbose_name="Наименование")
    description = models.TextField(null=True, blank=True, verbose_name="Описание")
    is_actual = models.BooleanField(verbose_name="Актуальность справочника", default=False)
    started_at = models.DateField(null=True, blank=True, verbose_name="Дата начала действия справочника")
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
        ordering = ['pk', 'title']


class DirectoryVersion(models.Model):
    """Версия справочника"""
    title = models.CharField(max_length=255, null=False, blank=False, verbose_name="Версия справочника")
    directory = models.ForeignKey(Directory, verbose_name='Справочник', on_delete=models.CASCADE)
    user = models.ForeignKey(User, verbose_name='Пользователь', on_delete=models.CASCADE)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('directory', kwargs={'dir_version_id': self.pk})

    class Meta:
        verbose_name = 'Версия справочника'
        verbose_name_plural = 'Версий справочника'
        ordering = ['pk', 'title']


class DirectoryElement(models.Model):
    """Элемент справочника"""
    directory_version = models.ForeignKey(DirectoryVersion, verbose_name='Справочник версия', on_delete=models.CASCADE)
    title = models.CharField(max_length=255, null=False, blank=False, verbose_name="Элемент справочника")
    description = models.TextField(null=False, blank=False, verbose_name="Значение элемента")
    user = models.ForeignKey(User, verbose_name='Пользователь', on_delete=models.CASCADE)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('directory', kwargs={'dir_element_id': self.pk})

    class Meta:
        verbose_name = 'Элемент справочника'
        verbose_name_plural = 'Элементы справочника'
        ordering = ['pk', 'title']
