from django.conf import settings
from django.db import models
from django.utils.translation import gettext_lazy as _
from .university import University
from .background import Background

class Admissions(models.Model):
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("related user"), 
        related_name="admissions",
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    related_university = models.ForeignKey(
        University,
        verbose_name=_("related university"), 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    related_program = models.CharField(
        max_length=255,
        null=False,
        blank=False
    )
    related_background = models.ForeignKey(
        Background,
        verbose_name="related_background",
        null=False, 
        blank=False,
        on_delete=models.CASCADE
    )
    result = models.BooleanField(
        null=False,
        blank=False
    )
    # !TODO: change to choiceField if applicable
    enrolledSemester = models.CharField(
        max_length=255,
        null=False,
        blank=False
    )
    comments = models.TextField(
        max_length=1024,
        null=True,
        blank=True
    )
    summary = models.TextField(
        max_length=1024,
        null=True,
        blank=True
    )
    created_time = models.DateTimeField(
        auto_now_add=True
    )
    upvoted = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="admissions_upvoted_by",
        null=True,
        blank=True
    )
    upvoted_count = models.PositiveIntegerField(
        default=0
    )