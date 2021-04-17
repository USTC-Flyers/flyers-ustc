from django.conf import settings
from django.db import models
from .choice import Choices
from multiselectfield import MultiSelectField
from picklefield.fields import PickledObjectField
from django.utils.translation import gettext_lazy as _
from django.contrib.postgres.fields import ArrayField

class Background(models.Model):
    related_user = models.OneToOneField(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("related user"),
        related_name="background", 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    major = models.CharField(
        choices=Choices.MAJORCHOICES,
        editable=True,
        null=True,
        max_length=255
    )
    gpa = models.FloatField(
        null=True, 
        blank=True
    )
    rank = models.CharField(
        choices=Choices.RANKCHOICES,
        null=True,
        blank=True,
        max_length=255
    )
    apply_for = models.CharField(
        choices=Choices.APPLYFORCHOICES,
        null=True,
        blank=True,
        max_length=255
    )
    TOEFL = models.CharField(
        max_length=255,
        null=True, 
        blank=True
    )
    GRE = models.CharField(
        max_length=256,
        null=True, 
        blank=True
    )
    researchSpec = models.TextField(
        max_length=1024,
        null=True,
        blank=True
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
        base_field=models.CharField(
            choices=Choices.choices_all,
            null=True,
            blank=True,
            max_length=255
        ),
        null=True,
        blank=True,
        default=list
    )
    summary = models.TextField(
        max_length=1024,
        null=True,
        blank=True,
    )