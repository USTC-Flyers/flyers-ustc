# Generated by Django 3.1.7 on 2021-04-12 09:20

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='userprofile',
            old_name='user',
            new_name='related_user',
        ),
    ]
