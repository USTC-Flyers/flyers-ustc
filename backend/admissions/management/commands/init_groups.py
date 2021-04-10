from ... import models
from django.core.management.base import BaseCommand, CommandError
from django.contrib.auth.models import Group

class Command(BaseCommand):
    help = 'initialize group set'
    
    def handle(self, *args, **options):
        for school in models.school_list:
            Group.objects.create(name=school)
        print('initialize group set ok')
                    