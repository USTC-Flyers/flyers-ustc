# Generated by Django 3.1.7 on 2021-04-26 08:49

import account.models.userProfile
from django.conf import settings
import django.contrib.auth.models
import django.contrib.auth.validators
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('username', models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.', max_length=150, unique=True, validators=[django.contrib.auth.validators.UnicodeUsernameValidator()], verbose_name='username')),
                ('first_name', models.CharField(blank=True, max_length=150, verbose_name='first name')),
                ('last_name', models.CharField(blank=True, max_length=150, verbose_name='last name')),
                ('email', models.EmailField(blank=True, max_length=254, verbose_name='email address')),
                ('is_staff', models.BooleanField(default=False, help_text='Designates whether the user can log into this admin site.', verbose_name='staff status')),
                ('is_active', models.BooleanField(default=True, help_text='Designates whether this user should be treated as active. Unselect this instead of deleting accounts.', verbose_name='active')),
                ('date_joined', models.DateTimeField(default=django.utils.timezone.now, verbose_name='date joined')),
                ('id', models.CharField(max_length=255, primary_key=True, serialize=False)),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.Group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.Permission', verbose_name='user permissions')),
            ],
            options={
                'verbose_name': 'user',
                'verbose_name_plural': 'users',
                'abstract': False,
            },
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('school', models.IntegerField(choices=[(0, '000: 少年班学院'), (1, '001: 数学科学学院'), (2, '203: 物理学院'), (3, '204: 管理学院'), (4, '206: 化学与材料科学学院'), (5, '207: 生命科学学院'), (6, '208: 地球和空间科学学院'), (7, '209: 工程科学学院'), (8, '210: 信息科学技术学院'), (9, '211: 人文与社会科学学院'), (10, '214: 核科学技术学院'), (11, '215: 计算机科学与技术学院'), (12, '216: 公共事务学院'), (13, '217: 环境科学与光电技术学院'), (14, '219: 微电子学院'), (15, '220: 马克思主义学院'), (16, '221: 网络空间安全学院'), (17, '225: 软件学院'), (18, '229: 大数据学院'), (19, '231: 国家同步辐射实验室'), (20, '232: 火灾科学国家重点实验室'), (21, '234: 合肥微尺度物质科学国家实验室（筹）'), (22, '240: 环境科学与工程系'), (23, '910: 生命科学与医学部 ')], null=True)),
                ('email', models.EmailField(blank=True, max_length=254, null=True)),
                ('wechat', models.CharField(blank=True, max_length=255, null=True)),
                ('qq', models.CharField(blank=True, max_length=255, null=True)),
                ('is_verified', models.BooleanField(default=False, verbose_name='是否通过科大统一身份验证')),
                ('role', models.IntegerField(choices=[(0, 'Student'), (1, 'Teacher'), (2, 'Alumni'), (3, 'Admin')], default=0)),
                ('avatar', models.ImageField(blank=True, max_length=255, upload_to=account.models.userProfile.avatar_path)),
                ('last_post_hash', models.CharField(blank=True, max_length=32, verbose_name='last post hash')),
                ('last_post_on', models.DateTimeField(blank=True, null=True, verbose_name='last post on')),
                ('followed', models.ManyToManyField(blank=True, null=True, related_name='followed_by', to='account.UserProfile')),
                ('related_user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
