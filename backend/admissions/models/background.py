from django.conf import settings
from django.db import models
from .choice import Choices
from multiselectfield import MultiSelectField
from picklefield.fields import PickledObjectField
from django.utils.translation import gettext_lazy as _
from django.contrib.postgres.fields import ArrayField

class Background(models.Model):
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("related user"),
        related_name="background", 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    major = models.IntegerField(
        choices=Choices.MAJORCHOICES,
        editable=True,
        null=True
    )
    gpa = models.FloatField(
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
    researchSpec = models.TextField(
        max_length=1024,
        null=False,
        blank=False
    )
    researchSpec = models.TextField(
        max_length=1024,
        null=True,
        blank=True
    )
    referSpec = models.TextField(
        max_length=1024,
        null=True,
        blank=True
    )
    tags = ArrayField(
        base_field=models.IntegerField(
            choices=Choices.choices_all,
            null=True,
            blank=True
        ),
        null=True,
        blank=True,
        default=list
    )
    summary = models.TextField(
        max_length=1024
    )