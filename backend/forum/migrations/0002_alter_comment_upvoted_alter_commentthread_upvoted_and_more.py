# Generated by Django 4.0.6 on 2022-07-26 03:31

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('forum', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='upvoted',
            field=models.ManyToManyField(blank=True, related_name='comment_upvoted_by', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='commentthread',
            name='upvoted',
            field=models.ManyToManyField(blank=True, related_name='comment_thread_upvoted_by', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='topic',
            name='followed',
            field=models.ManyToManyField(blank=True, related_name='topic_followed_by', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='topic',
            name='upvoted',
            field=models.ManyToManyField(blank=True, related_name='topic_upvoted_by', to=settings.AUTH_USER_MODEL),
        ),
    ]
