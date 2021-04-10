from django.db import models
from django.db.models import Q

class NotificationQueryset(models.QuerySet):
    def read(self, user):
        # returns updated rows count (int)
        return (
            self.filter(related_user=user)
            .update(is_read=True)
        )
        
    def unread_count(self, user):
        return self.filter(Q(related_user=user) & Q(is_read=False)).count()
        
    def users(self, user):
        return self.filter(related_user=user)