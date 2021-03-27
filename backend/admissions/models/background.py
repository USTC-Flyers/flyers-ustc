from django.conf import settings
from django.db import models
from .choice import MajorChoices, RankChoices, RecTagChoices, ResearchTagChoices, ApplyForChoices
from .validators import toefl_score, gre_score
from multiselectfield import MultiSelectField

class Background(models.Model):
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("related user"), 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    major = models.IntegerField(
        choices=MajorChoices.choices,
        null=False, 
        blank=False
    )
    gpa = models.FloatField(
        null=False, 
        blank=False
    )
    rank = models.IntegerField(
        choices = RankChoices.choices,
        null=False, 
        blank=False
    )
    TOEFL = models.CharField(
        max_length=256,
        validators=[toefl_score]
    )
    GRE = models.CharField(
        max_length=256,
        validators=[gre_score]
    )
    researchSpec = models.CharField(
        max_length=1024,
        null=False,
        blank=False
    )
    researchTag = MultiSelectField(
        choices=ResearchTagChoices.choices
    )
    researchSpec = models.CharField(
        max_length=1024
    )
    recTag = MultiSelectField(
        choices=RecTagChoices.choices
    )
    applyFor = MultiSelectField(
        choices=ApplyForChoices.choices
    )
    summary = models.CharField(
        max_length=1024
    )