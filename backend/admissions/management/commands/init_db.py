from ... import models
import json
from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth.models import Group
from django.apps import apps
from django.db import connection

class Command(BaseCommand):
    help = 'import university and programs data'
    
    def handle(self, *args, **options):
        filename = 'data/university_1p3a.json'
        with open(filename) as f:
            data = json.load(f)
            
        for univ in data:
            programs = univ.pop('programs')
            university = models.University.objects.create(
                **univ
            )
            if len(programs) > 1:
                for program in programs:
                    models.Program.objects.create(
                        related_university=university,
                        name=program['program'],
                        full_name=program['program_full_name']
                    )
                    
        for group in models.group_list:
            Group.objects.create(name=group)
        # Group.objects.create(name="general")
        
        User = apps.get_model('account.user')
        # u = User.objects.create_superuser('admin', '', 'admin')
        # u.id = 'admin'
        # u.save()
        u = User.objects.create(username='admin', email='', password='admin', gid='admin')
        ua = User.objects.create(username='test', email='', password='test', gid='test')
        Userprofile = apps.get_model('account.userprofile')
        # Userprofile.objects.create(nickname='nickname', related_user=u)
        # Userprofile.objects.create(nickname='nicknameA', related_user=ua)
        print('initialize ok')