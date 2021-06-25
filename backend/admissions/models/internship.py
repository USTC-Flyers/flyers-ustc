from djchoices import choices
from .choice import Choices
from django.conf import settings
from django.db import models
from django.utils.translation import gettext_lazy as _
from .university import University
from .intern_background import InternBackground
from django.db.utils import IntegrityError

class Internship(models.Model):
    INTERNCHOICES = [
        ("COLDCALL", "COLDCALL"),
        ("REFER", "REFER"),
        ("OFFICIALREFER", "OFFICIALREFER"),
        ("COOPERATION", "COOPERATION"),
    ]
    
    RESULTCHOICES = [
        ("ONLINE", "ONLINE"),
        ("ONSITEJ", "ONSITEJ"),
        ("ONSITEB", "ONSITEB"),
        ("OFFICIAL", "OFFICIAL")
    ]
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name=_("related user"), 
        related_name="internship",
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    related_university = models.ForeignKey(
        University,
        verbose_name=_("related_university"), 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    professor = models.CharField(
        max_length=255,
        null=False,
        blank=False
    )
    specialty = models.CharField(
        max_length=255,
        null=False,
        blank=False
    )
    is_done = models.BooleanField(
        null=True,
        blank=True,
        default=True
    )
    related_background = models.ForeignKey(
        InternBackground,
        verbose_name="related_background",
        null=False, 
        blank=False,
        on_delete=models.CASCADE
    )
    apply_exp = models.CharField(
        choices=INTERNCHOICES,
        max_length=255,
        null=True,
        blank=True
    )
    apply_spec = models.TextField(
        max_length=1024,
        null=True,
        
        blank=True
    )
    result = models.CharField(
        choices=RESULTCHOICES,
        max_length=255,
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
        related_name="internship_upvoted_by",
        null=True,
        blank=True
    )
    upvoted_count = models.PositiveIntegerField(
        default=0
    )
    
    def upvote(self, user):
        if self not in user.internship_upvoted_by.all():
            user.internship_upvoted_by.add(self)
            self.upvoted_count += 1
            self.save()        
        else:
            raise IntegrityError
    def downvote(self, user):
        if self in user.internship_upvoted_by.all():
            user.internship_upvoted_by.remove(self)
            self.upvoted_count -= 1
            self.save()
        else:
            raise IntegrityError