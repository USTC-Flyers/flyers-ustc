from django.db import models
from django.contrib.auth.models import AbstractUser
from .choice import school_list
from .validators import contact_email_qq_wechat
import os
from .user import User

SCHOOL_CHOICES = []
for i, school in enumerate(school_list):
    SCHOOL_CHOICES.append((i, school))
    
class UserProfile(models.Model):
    STUDENT, TEACHER, ALUMNI, ADMIN = range(4)
    ROLE_CHOICES = (
        (STUDENT, "Student"),
        (TEACHER, "Teacher"),
        (ALUMNI, "Alumni"),
        (ADMIN, "Admin")
    )
    related_user = models.OneToOneField(
        User,
        on_delete=models.CASCADE
    )
    nickname = models.CharField(
        max_length=255,
        null=True,
        blank=True
    )
    school = models.IntegerField(
        choices=SCHOOL_CHOICES,
        editable=True,
        null=True
    )
    contact = models.CharField(
        max_length=254,
        null=True,
        blank=True,
    )
    is_verified = models.BooleanField(
        verbose_name="是否通过科大统一身份验证",
        default=False
    )
    role = models.IntegerField(
        choices=ROLE_CHOICES,
        default=STUDENT
    )
    followed = models.ManyToManyField(
        'account.UserProfile',
        related_name="followed_by",
        null=True,
        blank=True
    )
    enrolledYear = models.CharField(
        max_length=255,
        null=True,
        blank=True
    )
    isUndergrad = models.BooleanField(
        blank=True,
        null=True
    )