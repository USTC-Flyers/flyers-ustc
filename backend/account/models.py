from django.db import models
from .department import DepartmentChoices
from .validators import contact_email_qq_wechat

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
    department = models.IntegerField(
        choices=DepartmentChoices.choices,
        black=False,
        null=False
    )
    contact = models.CharField(
        max_length=256,
        validators=[contact_email_qq_wechat])