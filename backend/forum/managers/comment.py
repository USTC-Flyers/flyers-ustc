from django.db import models

class CommentThreadQuerySet(models.QuerySet):
    def pinned(self):
        return self.filter(action=self.model.PINNED)
    
    def public(self):
        return self.exclude(action=self.model.CLOSED)
    
class CommentQuerySet(models.QuerySet):
    def pinned(self):
        return self.filter(action=self.model.PINNED)
    
    def public(self):
        return self.exclude(action=self.model.CLOSED)