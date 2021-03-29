from django.db import models

class University(models.Model):
    area = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )
    school_name = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )
    school_name_cn = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )
    short_name = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )