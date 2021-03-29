from django.db import models

class Program(models.Model):
    name = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )
    full_name = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )