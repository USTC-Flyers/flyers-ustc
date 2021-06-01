# Generated by Django 3.1.7 on 2021-06-01 04:14

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import forum.models.topic


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Topic',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('followed_count', models.PositiveIntegerField(default=0)),
                ('action', models.IntegerField(choices=[(0, 'topic'), (1, 'topic pinned'), (2, 'topic unpinned'), (3, 'topic closed'), (4, 'topic unclosed')], default=0)),
                ('hit_count', models.PositiveIntegerField(default=0)),
                ('comment_count', models.PositiveIntegerField(default=0, verbose_name='comment count')),
                ('upvoted_count', models.PositiveIntegerField(default=0)),
                ('is_valid', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='TopicRevision',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('revision_number', models.IntegerField()),
                ('title', models.TextField(max_length=255, verbose_name='title')),
                ('content', models.TextField(blank=True)),
                ('image', models.ImageField(blank=True, upload_to=forum.models.topic.image_path)),
                ('file', models.FileField(blank=True, upload_to=forum.models.topic.file_path)),
                ('created_time', models.DateTimeField(default=django.utils.timezone.now)),
                ('is_valid', models.BooleanField(default=False)),
                ('related_topic', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='topic_revision', to='forum.topic')),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='topic_revision', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('-created_time',),
                'get_latest_by': 'revision_number',
                'unique_together': {('related_topic', 'revision_number')},
            },
        ),
        migrations.AddField(
            model_name='topic',
            name='current_version',
            field=models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='topic', to='forum.topicrevision'),
        ),
        migrations.AddField(
            model_name='topic',
            name='followed',
            field=models.ManyToManyField(blank=True, null=True, related_name='topic_followed_by', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='topic',
            name='group',
            field=models.ForeignKey(blank=True, help_text='Like in a UNIX file system, permissions can be given to a user according to group membership. Groups are handled through the Django auth system.', null=True, on_delete=django.db.models.deletion.SET_NULL, to='auth.group', verbose_name='group'),
        ),
        migrations.AddField(
            model_name='topic',
            name='upvoted',
            field=models.ManyToManyField(blank=True, null=True, related_name='topic_upvoted_by', to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='Notification',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_time', models.DateTimeField(default=django.utils.timezone.now)),
                ('ref_obj_name', models.CharField(max_length=255)),
                ('ref_obj_id', models.IntegerField()),
                ('message', models.TextField(blank=True, null=True)),
                ('is_read', models.BooleanField(default=False)),
                ('operation', models.IntegerField(choices=[(0, '已更新'), (1, '被点赞'), (2, '被管理员删除'), (3, '审核通过'), (4, '审核未通过'), (5, '被回复'), (6, '被提到'), (7, '被管理员置顶'), (8, '被管理员取消置顶'), (9, '请求更改wiki'), (10, '被举报'), (11, '出bug了...')], default=11)),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='notification', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='CommentThread',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(max_length=500)),
                ('action', models.IntegerField(choices=[(0, 'comment'), (1, 'comment pinned'), (2, 'comment unpinned'), (3, 'topic closed'), (4, 'topic unclosed')], default=0)),
                ('created_time', models.DateTimeField(default=django.utils.timezone.now)),
                ('is_anonymous', models.BooleanField(default=False)),
                ('upvoted_count', models.PositiveIntegerField(default=0)),
                ('related_topic', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comment_related_topic', to='forum.topic')),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comment_thread', to=settings.AUTH_USER_MODEL)),
                ('upvoted', models.ManyToManyField(blank=True, null=True, related_name='comment_thread_upvoted_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(max_length=500)),
                ('action', models.IntegerField(choices=[(0, 'comment'), (1, 'comment pinned'), (2, 'comment unpinned'), (3, 'topic closed'), (4, 'topic unclosed')], default=0)),
                ('created_time', models.DateTimeField(default=django.utils.timezone.now)),
                ('upvoted_count', models.PositiveIntegerField(default=0)),
                ('related_comment_thread', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comment', to='forum.commentthread')),
                ('related_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='comment', to=settings.AUTH_USER_MODEL)),
                ('upvoted', models.ManyToManyField(blank=True, null=True, related_name='comment_upvoted_by', to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
