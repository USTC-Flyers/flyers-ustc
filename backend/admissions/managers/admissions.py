from django.db import models
from django.db.models import Q, Prefetch
from django.apps import apps

class AdmissionsQueryset(models.QuerySet):
    def condition(self, *args, **kwargs):
        # 可选的filter项
        # background: major, rankTag, researchTag, referTag, applyFor
        # admission: related_university, related_program, result, enrolledSemester
        admission_filter = ['related_university', 'related_program', 'result', 'enrolledSemester']
        if 'tags' in kwargs:
            tags = kwargs['tags']
            kwargs.pop('tags')
        query = Q()
        for tag in admission_filter:
            if tag in kwargs:
                query &= Q(**{tag: kwargs[tag]})
                
        return self.filter(query).filter(related_background__tags__contains=tags).select_related('related_university', 'related_program', 'related_background')