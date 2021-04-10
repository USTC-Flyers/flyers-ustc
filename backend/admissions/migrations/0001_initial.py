# Generated by Django 3.1.7 on 2021-04-10 08:26

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import multiselectfield.db.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='University',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('area', models.CharField(max_length=256)),
                ('school_name', models.CharField(max_length=256)),
                ('school_name_cn', models.CharField(max_length=256)),
                ('short_name', models.CharField(max_length=256)),
            ],
        ),
        migrations.CreateModel(
            name='Program',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=256)),
                ('full_name', models.CharField(max_length=256)),
                ('related_university', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='program', to='admissions.university', verbose_name='related_university')),
            ],
        ),
        migrations.CreateModel(
            name='Background',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('major', models.CharField(max_length=256)),
                ('gpa', models.FloatField()),
                ('rank', models.CharField(max_length=256)),
                ('TOEFL', models.CharField(max_length=256)),
                ('GRE', models.CharField(max_length=256)),
                ('researchTag', models.CharField(max_length=256)),
                ('researchSpec', models.CharField(blank=True, max_length=1024, null=True)),
                ('referTag', models.CharField(max_length=256)),
                ('referSpec', models.CharField(blank=True, max_length=1024, null=True)),
                ('applyFor', models.CharField(max_length=256)),
                ('summary', models.CharField(max_length=1024)),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='background', to=settings.AUTH_USER_MODEL, verbose_name='related user')),
            ],
        ),
        migrations.CreateModel(
            name='Admissions',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('result', models.BooleanField()),
                ('enrolledSemester', models.CharField(max_length=256)),
                ('comments', models.CharField(max_length=1024)),
                ('tag', multiselectfield.db.fields.MultiSelectField(choices=[('admitted', 'admitted'), ('reject', 'reject'), ('waitlist', 'waitlist')], max_length=24)),
                ('related_program', models.ForeignKey(default='', on_delete=django.db.models.deletion.CASCADE, to='admissions.program', verbose_name='related program')),
                ('related_university', models.ForeignKey(default='', on_delete=django.db.models.deletion.CASCADE, to='admissions.university', verbose_name='related university')),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='admissions', to=settings.AUTH_USER_MODEL, verbose_name='related user')),
            ],
        ),
    ]
