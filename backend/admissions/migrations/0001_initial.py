# Generated by Django 3.1.7 on 2021-06-25 08:47

from django.conf import settings
import django.contrib.postgres.fields
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='InternBackground',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('major', models.CharField(choices=[('045', '045: 数学系'), ('046', '046: 计算与应用数学系'), ('047', '047: 概率统计系'), ('002', '002: 物理学系'), ('004', '004: 近代物理系'), ('022', '022: 天文学系'), ('038', '038: 光学与光学工程系'), ('048', '048: 工程与应用物理系'), ('015', '015: 工商管理系'), ('016', '016: 管理科学系'), ('017', '017: 统计与金融系'), ('034', '034: MBA中心'), ('035', '035: MPA中心'), ('039', '039: EMBA'), ('003', '003: 化学物理系'), ('012', '012: 应用化学系'), ('014', '014: 材料科学与工程系'), ('019', '019: 化学系'), ('020', '020: 高分子科学与工程系'), ('008', '008: 分子生物学与细胞生物学系'), ('021', '021: 神经生物学与生物物理学系'), ('031', '031: 系统生物学系'), ('032', '032: 医药生物技术系'), ('071', '071: 地球物理与行星科学技术系'), ('072', '072: 地球化学与环境科学系'), ('005', '005: 近代力学系'), ('009', '009: 精密机械与精密仪器系'), ('013', '013: 热科学和能源工程系'), ('030', '030: 安全科学与工程系'), ('006', '006: 电子工程与信息科学系'), ('010', '010: 自动化系'), ('023', '023: 电子科学与技术系'), ('033', '033: 信息安全'), ('018', '018: 外语系'), ('024', '024: 科技史与科技考古系'), ('025', '025: 科技传播与科技政策系'), ('055', '055: 科技哲学系'), ('056', '056: 心理学系'), ('011', '011: 计算机科学与技术系'), ('044', '044: 物流工程硕士中心')], max_length=255, null=True)),
                ('gpa', models.FloatField(blank=True, null=True)),
                ('rank', models.CharField(blank=True, choices=[('top1%', 'top1%'), ('top5%', 'top5%'), ('top10%', 'top10%'), ('top20%', 'top20%'), ('top30%', 'top30%'), ('top50%', 'top50%'), ('else', 'else')], max_length=255, null=True)),
                ('TOEFL', models.CharField(blank=True, max_length=255, null=True)),
                ('researchSpec', models.TextField(blank=True, max_length=1024, null=True)),
                ('tags', django.contrib.postgres.fields.ArrayField(base_field=models.CharField(blank=True, choices=[('oversea_refer', 'oversea_refer'), ('bigname_refer', 'bigname_refer'), ('connection', 'connection'), ('oversea_research', 'oversea_research'), ('paper', 'paper'), ('first_author', 'first_author'), ('internship', 'internship')], max_length=255, null=True), blank=True, default=list, null=True, size=None)),
                ('upvoted_count', models.PositiveIntegerField(default=0)),
                ('related_user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='intern_background', to=settings.AUTH_USER_MODEL, verbose_name='related user')),
                ('upvoted', models.ManyToManyField(blank=True, null=True, related_name='internbackground_upvoted_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
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
            name='Internship',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('professor', models.CharField(max_length=255)),
                ('specialty', models.CharField(max_length=255)),
                ('is_done', models.BooleanField(blank=True, default=True, null=True)),
                ('apply_exp', models.CharField(blank=True, choices=[('COLDCALL', 'COLDCALL'), ('REFER', 'REFER'), ('OFFICIALREFER', 'OFFICIALREFER'), ('COOPERATION', 'COOPERATION')], max_length=255, null=True)),
                ('apply_spec', models.TextField(blank=True, max_length=1024, null=True)),
                ('result', models.CharField(blank=True, choices=[('ONLINE', 'ONLINE'), ('ONSITEJ', 'ONSITEJ'), ('ONSITEB', 'ONSITEB'), ('OFFICIAL', 'OFFICIAL')], max_length=255, null=True)),
                ('summary', models.TextField(blank=True, max_length=1024, null=True)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('upvoted_count', models.PositiveIntegerField(default=0)),
                ('related_background', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='admissions.internbackground', verbose_name='related_background')),
                ('related_university', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='admissions.university', verbose_name='related_university')),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='internship', to=settings.AUTH_USER_MODEL, verbose_name='related user')),
                ('upvoted', models.ManyToManyField(blank=True, null=True, related_name='internship_upvoted_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Background',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('major', models.CharField(choices=[('045', '045: 数学系'), ('046', '046: 计算与应用数学系'), ('047', '047: 概率统计系'), ('002', '002: 物理学系'), ('004', '004: 近代物理系'), ('022', '022: 天文学系'), ('038', '038: 光学与光学工程系'), ('048', '048: 工程与应用物理系'), ('015', '015: 工商管理系'), ('016', '016: 管理科学系'), ('017', '017: 统计与金融系'), ('034', '034: MBA中心'), ('035', '035: MPA中心'), ('039', '039: EMBA'), ('003', '003: 化学物理系'), ('012', '012: 应用化学系'), ('014', '014: 材料科学与工程系'), ('019', '019: 化学系'), ('020', '020: 高分子科学与工程系'), ('008', '008: 分子生物学与细胞生物学系'), ('021', '021: 神经生物学与生物物理学系'), ('031', '031: 系统生物学系'), ('032', '032: 医药生物技术系'), ('071', '071: 地球物理与行星科学技术系'), ('072', '072: 地球化学与环境科学系'), ('005', '005: 近代力学系'), ('009', '009: 精密机械与精密仪器系'), ('013', '013: 热科学和能源工程系'), ('030', '030: 安全科学与工程系'), ('006', '006: 电子工程与信息科学系'), ('010', '010: 自动化系'), ('023', '023: 电子科学与技术系'), ('033', '033: 信息安全'), ('018', '018: 外语系'), ('024', '024: 科技史与科技考古系'), ('025', '025: 科技传播与科技政策系'), ('055', '055: 科技哲学系'), ('056', '056: 心理学系'), ('011', '011: 计算机科学与技术系'), ('044', '044: 物流工程硕士中心')], max_length=255, null=True)),
                ('gpa', models.FloatField(blank=True, null=True)),
                ('rank', models.CharField(blank=True, choices=[('top1%', 'top1%'), ('top5%', 'top5%'), ('top10%', 'top10%'), ('top20%', 'top20%'), ('top30%', 'top30%'), ('top50%', 'top50%'), ('else', 'else')], max_length=255, null=True)),
                ('apply_for', models.CharField(blank=True, choices=[('ms', 'ms'), ('phd', 'phd'), ('ms_phd', 'ms_phd')], max_length=255, null=True)),
                ('TOEFL', models.CharField(blank=True, max_length=255, null=True)),
                ('GRE', models.CharField(blank=True, max_length=256, null=True)),
                ('score', models.CharField(blank=True, max_length=256, null=True)),
                ('researchSpec', models.TextField(blank=True, max_length=1024, null=True)),
                ('referSpec', models.TextField(blank=True, max_length=1024, null=True)),
                ('tags', django.contrib.postgres.fields.ArrayField(base_field=models.CharField(blank=True, choices=[('oversea_refer', 'oversea_refer'), ('bigname_refer', 'bigname_refer'), ('connection', 'connection'), ('oversea_research', 'oversea_research'), ('paper', 'paper'), ('first_author', 'first_author'), ('internship', 'internship')], max_length=255, null=True), blank=True, default=list, null=True, size=None)),
                ('comments', models.TextField(blank=True, null=True)),
                ('summary', models.TextField(blank=True, null=True)),
                ('upvoted_count', models.PositiveIntegerField(default=0)),
                ('related_user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='background', to=settings.AUTH_USER_MODEL, verbose_name='related user')),
                ('upvoted', models.ManyToManyField(blank=True, null=True, related_name='background_upvoted_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Admissions',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('related_program', models.CharField(max_length=255)),
                ('result', models.BooleanField()),
                ('enrolledSemester', models.CharField(max_length=255)),
                ('comments', models.TextField(blank=True, max_length=1024, null=True)),
                ('summary', models.TextField(blank=True, max_length=1024, null=True)),
                ('created_time', models.DateTimeField(auto_now_add=True)),
                ('upvoted_count', models.PositiveIntegerField(default=0)),
                ('related_background', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='admissions.background', verbose_name='related_background')),
                ('related_university', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='admissions.university', verbose_name='related university')),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='admissions', to=settings.AUTH_USER_MODEL, verbose_name='related user')),
                ('upvoted', models.ManyToManyField(blank=True, null=True, related_name='admissions_upvoted_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
