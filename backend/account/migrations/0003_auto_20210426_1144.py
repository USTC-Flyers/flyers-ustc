# Generated by Django 3.1.7 on 2021-04-26 11:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0002_auto_20210417_0828'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='userprofile',
            name='email',
        ),
        migrations.RemoveField(
            model_name='userprofile',
            name='qq',
        ),
        migrations.RemoveField(
            model_name='userprofile',
            name='wechat',
        ),
        migrations.AddField(
            model_name='userprofile',
            name='contact',
            field=models.EmailField(blank=True, max_length=254, null=True),
        ),
    ]
