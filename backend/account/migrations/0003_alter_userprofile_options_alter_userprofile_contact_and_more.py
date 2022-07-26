# Generated by Django 4.0.6 on 2022-07-26 03:31

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('admissions', '0002_alter_admissions_options_alter_background_options_and_more'),
        ('account', '0002_auto_20210625_1647'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='userprofile',
            options={'verbose_name': '用户信息', 'verbose_name_plural': '用户信息'},
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='contact',
            field=models.CharField(blank=True, max_length=254, null=True, verbose_name='联系方式'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='enrolledYear',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='入学年份'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='final_program',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='最后项目'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='final_university',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='admissions.university', verbose_name='录取学校'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='followed',
            field=models.ManyToManyField(blank=True, related_name='followed_by', to='account.userprofile'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='isUndergrad',
            field=models.BooleanField(blank=True, null=True, verbose_name='在校时是否为本科生'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='is_verified',
            field=models.BooleanField(default=False, verbose_name='通过统一身份验证'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='nickname',
            field=models.CharField(blank=True, max_length=255, null=True, verbose_name='昵称'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='related_user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='userprofile', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='role',
            field=models.IntegerField(choices=[(0, 'Student'), (1, 'Teacher'), (2, 'Alumni'), (3, 'Admin')], default=0, verbose_name='身份'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='school',
            field=models.IntegerField(choices=[(0, '000: 少年班学院'), (1, '001: 数学科学学院'), (2, '203: 物理学院'), (3, '204: 管理学院'), (4, '206: 化学与材料科学学院'), (5, '207: 生命科学学院'), (6, '208: 地球和空间科学学院'), (7, '209: 工程科学学院'), (8, '210: 信息科学技术学院'), (9, '211: 人文与社会科学学院'), (10, '214: 核科学技术学院'), (11, '215: 计算机科学与技术学院'), (12, '216: 公共事务学院'), (13, '217: 环境科学与光电技术学院'), (14, '219: 微电子学院'), (15, '220: 马克思主义学院'), (16, '221: 网络空间安全学院'), (17, '225: 软件学院'), (18, '229: 大数据学院'), (19, '231: 国家同步辐射实验室'), (20, '232: 火灾科学国家重点实验室'), (21, '234: 合肥微尺度物质科学国家实验室（筹）'), (22, '240: 环境科学与工程系'), (23, '910: 生命科学与医学部 ')], null=True, verbose_name='学院'),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='university',
            field=models.CharField(default='ustc', max_length=255, verbose_name='学校'),
        ),
    ]