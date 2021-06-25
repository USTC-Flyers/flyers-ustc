from ... import models
from django.apps import apps
from django.contrib.auth.models import Group
from django.core.management.base import BaseCommand, CommandError

class Command(BaseCommand):
    help = 'import university and programs data'
    
    def handle(self, *args, **options):
        topic = apps.get_model('forum.topic')
        topic_revision = apps.get_model('forum.topicrevision')

        User = apps.get_model('account.user')
        user = User.objects.first()
        general_title = ['选择多样性', '申请总体规划', '暑研', '套瓷', 'CV、文书写作', '转专业申请', '国家/地区申请经验', 'GAP']
        for title in general_title:
            group = Group.objects.get(name="general")
            t = topic.objects.create(group=group, status=2)
            tr = topic_revision.objects.create(related_topic=t, title=title + ' 经验', content='<p>default content</p>', related_user=user, revision_number=0)
            t.current_version = tr
            t.save()

        for school in models.school_list:
            group = Group.objects.get(name=school)
            t = topic.objects.create(group=group, status=2)
            tr = topic_revision.objects.create(related_topic=t, title=school + ' 版', content='<p>default content</p>', related_user=user, revision_number=0)
            t.current_version = tr
            t.save()
            
        print('init topic ok!')