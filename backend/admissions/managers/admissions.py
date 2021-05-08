from django.db import models
from django.db.models import Q, Prefetch
from django.apps import apps
from ..models.choice import rank_tag

# class AdmissionsQueryset(models.QuerySet):
    # def condition(self, *args, **kwargs):
        
                
    #     return self.filter(query).select_related('related_university', 'related_background').order_by('-created_time')