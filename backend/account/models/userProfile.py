from django.db import models
from .choice import school_list
from .user import User
from django.apps import apps
from django.db.utils import ProgrammingError

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
        on_delete=models.CASCADE,
        related_name='userprofile'
    )
    nickname = models.CharField(
        max_length=255,
        null=True,
        blank=True,
        verbose_name='昵称'
    )
    school = models.IntegerField(
        choices=SCHOOL_CHOICES,
        editable=True,
        null=True,
        verbose_name='学院'
    )
    contact = models.CharField(
        max_length=254,
        null=True,
        blank=True,
        verbose_name='联系方式'
    )
    is_verified = models.BooleanField(
        verbose_name="通过统一身份验证",
        default=False
    )
    role = models.IntegerField(
        choices=ROLE_CHOICES,
        default=STUDENT,
        verbose_name='身份'
    )
    followed = models.ManyToManyField(
        'account.UserProfile',
        related_name="followed_by",
        blank=True
    )
    enrolledYear = models.CharField(
        max_length=255,
        null=True,
        blank=True,
        verbose_name='入学年份'
    )
    isUndergrad = models.BooleanField(
        blank=True,
        null=True,
        verbose_name='在校时身份'
    )
    final_university = models.ForeignKey(
        "admissions.university",
        verbose_name="录取学校",
        null=True,
        blank=True,
        on_delete=models.CASCADE,
    )
    final_program = models.CharField(
        max_length=255,
        null=True,
        blank=True,
        verbose_name='最后项目'
    )
    university = models.CharField(
        max_length=255,
        default='ustc',
        verbose_name='学校'
    )
    
    def get_all_votes_cnt(self):
        user = self.related_user
        count_objects = ['admissions', 'background', 'comment_thread', 'comment']
        model_name = ['admissions.admissions', 'admissions.background', 'forum.commentthread', 'forum.comment']
        cnt = 0
        for i, obj_name in enumerate(count_objects):
            obj_model = apps.get_model(model_name[i])
            try:
                objs = getattr(user, obj_name)
            except (ProgrammingError, obj_model.DoesNotExist, ValueError):
                continue
            # check is queryset or instance
            if isinstance(objs, obj_model):
                cnt += self.get_related_upvoted_count(objs)
            else:
                for obj in objs.all():
                    cnt += self.get_related_upvoted_count(obj)
        return cnt
    
    def get_related_upvoted_count(self, obj):
        try:
            return obj.upvoted_count
        except AttributeError:
            try:
                return obj.related_topic.upvoted_count
            except AttributeError:
                return 0

    def __str__(self):
        return '{}(id: {})'.format(self.nickname, self.id)

    class Meta:
        verbose_name = '用户信息'
        verbose_name_plural = verbose_name
