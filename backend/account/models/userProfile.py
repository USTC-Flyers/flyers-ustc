from django.db import models
from django.contrib.auth.models import AbstractUser
from .choice import school_list
from .validators import contact_email_qq_wechat
import os
from .user import User

SCHOOL_CHOICES = []
for i, school in enumerate(school_list):
    SCHOOL_CHOICES.append((i, school))
    
def avatar_path(instance, filename):
    ext = os.path.splitext(filename)[1].lower()
    return os.path.join(
        'flyers', 'avatars', str(instance.user_id), 'pic' + ext)

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
    # !TODO: storage
    avatar = models.ImageField(
        upload_to=avatar_path,
        max_length=255, 
        blank=True
    )
    followed = models.ManyToManyField(
        'account.UserProfile',
        related_name="followed_by",
        null=True,
        blank=True
    )
    last_post_hash = models.CharField(
        "last post hash",
        max_length=32,
        blank=True
    )
    last_post_on = models.DateTimeField(
        "last post on",
        null=True,
        blank=True
    )