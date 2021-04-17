# Generated by Django 3.1.7 on 2021-04-17 08:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('account', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='followed',
            field=models.ManyToManyField(blank=True, null=True, related_name='followed_by', to='account.UserProfile'),
        ),
    ]
