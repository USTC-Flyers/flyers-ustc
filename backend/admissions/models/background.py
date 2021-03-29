from django.conf import settings
from django.db import models
from .choice import Choices
from multiselectfield import MultiSelectField
from picklefield.fields import PickledObjectField
from django.utils.translation import gettext_lazy as _

class Background(models.Model):
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("related user"), 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    major = models.CharField(
        max_length=256,
        null=False, 
        blank=False
    )
    gpa = models.FloatField(
        null=False, 
        blank=False
    )
    rank = models.CharField(
        max_length=256,
        null=False, 
        blank=False
    )
    TOEFL = models.CharField(
        max_length=256,
        null=False, 
        blank=False
    )
    GRE = models.CharField(
        max_length=256,
        null=False, 
        blank=False
    )
    researchSpec = models.CharField(
        max_length=1024,
        null=False,
        blank=False
    )
    researchTag = models.CharField(
        max_length=256,
        null=False, 
        blank=False
    )
    researchSpec = models.CharField(
        max_length=1024,
        null=True,
        blank=True
    )
    referTag = models.CharField(
        max_length=256,
        null=False, 
        blank=False
    )
    referSpec = models.CharField(
        max_length=1024,
        null=True,
        blank=True
    )
    applyFor = models.CharField(
        max_length=256,
        null=False, 
        blank=False
    )
    summary = models.CharField(
        max_length=1024
    )