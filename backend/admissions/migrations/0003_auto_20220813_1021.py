# Generated by Django 4.0.6 on 2022-08-13 02:21

from django.db import migrations
from django.contrib.postgres.operations import UnaccentExtension


class Migration(migrations.Migration):

    dependencies = [
        ('admissions', '0002_alter_admissions_options_alter_background_options_and_more'),
    ]

    operations = [
            UnaccentExtension()
    ]
