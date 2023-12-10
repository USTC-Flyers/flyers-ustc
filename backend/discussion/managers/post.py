from django.db import models


class PostQuerySet(models.QuerySet):

    def public(self):
        return self.filter()



