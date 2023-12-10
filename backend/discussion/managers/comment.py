from django.db import models
from django.db.models import Q


class CommentQuerySet(models.QuerySet):

    def public(self):
        return self.filter()