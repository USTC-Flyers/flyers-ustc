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
    major = models.IntegerField(
        choices=Choices.MAJORCHOICES,
        null=False, 
        blank=False
    )
    gpa = models.FloatField(
        null=False, 
        blank=False
    )
    rank = models.IntegerField(
        choices=Choices.RANKCHOICES,
        null=False, 
        blank=False
    )
    TOEFL = PickledObjectField(
        editable=True
    )
    GRE = PickledObjectField(
        editable=True
    )
    researchSpec = models.CharField(
        max_length=1024,
        null=False,
        blank=False
    )
    researchTag = MultiSelectField(
        choices=Choices.RESEARCHCHOICES
    )
    researchSpec = models.CharField(
        max_length=1024
    )
    referTag = MultiSelectField(
        choices=Choices.REFERCHOICES
    )
    applyFor = MultiSelectField(
        choices=Choices.APPLYFORCHOICES
    )
    summary = models.CharField(
        max_length=1024
    )