# Generated by Django 3.1.7 on 2021-04-29 12:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('forum', '0002_remove_topic_view_count'),
    ]

    operations = [
        migrations.AddField(
            model_name='topic',
            name='hit_count',
            field=models.PositiveIntegerField(default=0),
        ),
    ]
