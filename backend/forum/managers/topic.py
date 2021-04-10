from django.db import models
from django.db.models import Q, Prefetch
from django.core.exceptions import ObjectDoesNotExist

class TopicQuerySet(models.QuerySet):
    def revision_set(self, pk):
        queryset = self.filter(pk=pk)
        prefetch = Prefetch(
            "TopicRevision",
            queryset=queryset,
            is_valid=True
        )
        return self.prefetch_related(prefetch)
    
    def public(self):
        return self.filter(is_valid=True)