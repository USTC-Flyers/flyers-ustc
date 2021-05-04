from django.db import models
from django.db.models import Q, Prefetch
from django.apps import apps
from ..models.choice import rank_tag

class AdmissionsQueryset(models.QuerySet):
    def condition(self, *args, **kwargs):
        admission_filter = ['related_university', 'related_program', 'result', 'enrolledSemester']
        query = Q()
        if 'tags' in kwargs:
            tags = kwargs['tags']
            query &= Q(related_background__tags__contains=tags)
        if 'rank' in kwargs:
            rank_dict = dict(zip(rank_tag, range(len(rank_tag))))
            rank_num = rank_dict[kwargs['rank']]
            rank_list = []
            for i in range(rank_num):
                rank_list.append(rank_tag[i])
            query &= Q(related_background__rank__in=rank_list)
        if 'apply_for' in kwargs:
            query &= Q(related_background__apply_for=kwargs['apply_for'])
        if 'major' in kwargs:
            query &= Q(related_background__major=kwargs['major'])
        for tag in admission_filter:
            if tag in kwargs:
                query &= Q(**{tag: kwargs[tag]})
                
        return self.filter(query).select_related('related_university', 'related_background')