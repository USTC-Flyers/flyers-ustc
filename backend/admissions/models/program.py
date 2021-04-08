from django.db import models
from .university import University

class Program(models.Model):
    related_university = models.ForeignKey(
        University, 
        verbose_name="related_university", 
        related_name="program",
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
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