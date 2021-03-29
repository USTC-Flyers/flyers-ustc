from django.db import models
from django.contrib.auth.models import AbstractUser
from .choice import school_list
from .validators import contact_email_qq_wechat

SCHOOL_CHOICES = []
for school in school_list:
    idx = school.split(':')[0]
    SCHOOL_CHOICES.append((idx, school))

# !TODO: add cas login
class User(AbstractUser):
    school = models.IntegerField(
        choices=SCHOOL_CHOICES,
        editable=True,
        null=True
    )
    contact = models.CharField(
        max_length=256,
        validators=[contact_email_qq_wechat],
        null=True)