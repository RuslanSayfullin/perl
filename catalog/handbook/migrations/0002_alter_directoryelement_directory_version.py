# Generated by Django 4.0.2 on 2022-04-05 10:41

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('handbook', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='directoryelement',
            name='directory_version',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='handbook.directoryversion', verbose_name='Справочник версия'),
        ),
    ]
