from django.conf import settings
from django.db import models
from multiselectfield import MultiSelectField
from .choice import AdmissionChoices
from .validators import enrolled_semester
from django.utils.translation import gettext_lazy as _
from .university import University
from .program import Program

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
        blank=False,
        default=''
    )
    related_program = models.ForeignKey(
        Program,
        verbose_name=_("related program"), 
        on_delete=models.CASCADE,
        null=False,
        blank=False,
        default=''
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