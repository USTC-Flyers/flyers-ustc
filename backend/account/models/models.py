from django.db import models
from .choices import school_list
from .validators import contact_email_qq_wechat

SCHOOL_CHOICES = []
for school in school_list:
    idx = school.split(':')[0]
    SCHOOL_CHOICES.append((idx, school))
    
class User(model.Model):
    name = models.CharField(
        max_length=50,
        null=False,
        blank=False,
        unique=True)
    sid = models.CharField(
        max_length=10,
        null=False,
        blank=False,
        unique=True)
    school = models.IntegerField(
        choices=SCHOOL_CHOICES,
        black=False,
        null=False
    )
    contact = models.CharField(
        max_length=256,
        validators=[contact_email_qq_wechat])