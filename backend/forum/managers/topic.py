from django.db import models
from django.db.models import Q, Prefetch
from django.core.exceptions import ObjectDoesNotExist

class TopicQuerySet(models.QuerySet):
    def public(self):
        return self.filter(is_valid=True)
    
    def user_followed(self, user):
        return self.filter(followed__contains=user)
    
class TopicRevisionQuerySet(models.QuerySet):
    def user_history(self, pk):
        return self.filter(related_user_id=pk)
    
    def revision_set(self, pk):
        return self.all().filter(related_topic_id=pk) 
    
    def public(self):
        return self.filter(is_valid=True)