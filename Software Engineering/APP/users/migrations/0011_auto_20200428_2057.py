# Generated by Django 3.0.5 on 2020-04-29 00:57

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0010_auto_20200428_2055'),
    ]

    operations = [
        migrations.AddField(
            model_name='survey',
            name='enddate',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
        migrations.AddField(
            model_name='survey',
            name='startdate',
            field=models.DateTimeField(default=django.utils.timezone.now),
        ),
    ]
