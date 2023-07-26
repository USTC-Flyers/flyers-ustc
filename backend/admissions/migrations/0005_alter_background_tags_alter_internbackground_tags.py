# Generated by Django 4.0.6 on 2023-07-23 04:33

import django.contrib.postgres.fields
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('admissions', '0004_research'),
    ]

    operations = [
        migrations.AlterField(
            model_name='background',
            name='tags',
            field=django.contrib.postgres.fields.ArrayField(base_field=models.CharField(blank=True, choices=[('oversea_refer', 'oversea_refer'), ('bigname_refer', 'bigname_refer'), ('connection', 'connection'), ('oversea_research', 'oversea_research'), ('paper', 'paper'), ('first_author', 'first_author'), ('internship', 'internship'), ('graudate', 'graudate')], max_length=255, null=True), blank=True, default=list, null=True, size=None),
        ),
        migrations.AlterField(
            model_name='internbackground',
            name='tags',
            field=django.contrib.postgres.fields.ArrayField(base_field=models.CharField(blank=True, choices=[('oversea_refer', 'oversea_refer'), ('bigname_refer', 'bigname_refer'), ('connection', 'connection'), ('oversea_research', 'oversea_research'), ('paper', 'paper'), ('first_author', 'first_author'), ('internship', 'internship'), ('graudate', 'graudate')], max_length=255, null=True), blank=True, default=list, null=True, size=None),
        ),
    ]