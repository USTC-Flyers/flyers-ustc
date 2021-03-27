from django.conf import settings
from django.db import models
from multiselectfield import MultiSelectField
from .choice import AdmissionChoices
from .validators import enrolled_semester

class Admissions(model.Model):
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("related user"), 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    # !TODO: change to choiceField if applicable
    university = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )
    program = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )
    result = models.BooleanField(
        null=False,
        blank=False
    )
    # !TODO: change to choiceField if applicable
    enrolledSemester = models.CharField(
        max_length=256,
        null=False,
        blank=False
    )
    comments = models.CharField(
        max_length=1024
    )
    tag = MultiSelectField(
        choices=AdmissionChoices.choices
    )