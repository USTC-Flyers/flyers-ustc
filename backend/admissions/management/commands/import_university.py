from ... import models
import json
from django.core.management.base import BaseCommand, CommandError

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
                    