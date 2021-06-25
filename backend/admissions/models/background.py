from django.conf import settings
from django.db import models
from .choice import Choices
from multiselectfield import MultiSelectField
from picklefield.fields import PickledObjectField
from django.utils.translation import gettext_lazy as _
from django.contrib.postgres.fields import ArrayField
from django.db.utils import IntegrityError

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
    score = models.CharField(
        max_length=256,
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
    comments = models.TextField(
        null=True,
        blank=True
    )
    summary = models.TextField(
        null=True,
        blank=True,
    )
    upvoted = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="background_upvoted_by",
        null=True,
        blank=True
    )
    upvoted_count = models.PositiveIntegerField(
        default=0
    )
    
    def upvote(self, user):
        if self not in user.background_upvoted_by.all():
            user.background_upvoted_by.add(self)
            self.upvoted_count += 1
            self.save()
        else:
            raise IntegrityError
        
    def downvote(self, user):
        if self in user.background_upvoted_by.all():
            user.background_upvoted_by.remove(self)
            self.upvoted_count -= 1
            self.save()
        else:
            raise IntegrityError