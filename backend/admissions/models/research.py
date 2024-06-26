from django.conf import settings
from django.db import models
from django.db.utils import IntegrityError
from .university import University
from .background import Background
from django.db.utils import IntegrityError


class Research(models.Model):
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        verbose_name="关联用户",
        related_name="research",
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    related_university = models.ForeignKey(
        University,
        verbose_name="学校",
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    related_program = models.CharField(
        max_length=255,
        verbose_name='项目名称',
        null=False,
        blank=False
    )
    related_background = models.ForeignKey(
        Background,
        verbose_name="经历",
        null=False,
        blank=False,
        on_delete=models.CASCADE
    )
    gpa = models.FloatField(
        null=True,
        verbose_name='当前绩点',
        blank=True
    )
    TOEFL = models.CharField(
        max_length=255,
        verbose_name='当前TOEFL',
        null=True, 
        blank=True
    )
    GRE = models.CharField(
        max_length=256,
        verbose_name='当前GRE',
        null=True, 
        blank=True
    )
    result = models.BooleanField(
        null=False,
        blank=False,
        verbose_name='是否成功'
    )
    # !TODO: change to choiceField if applicable
    semester = models.CharField(
        max_length=255,
        null=False,
        blank=False,
        verbose_name='申请学年'
    )
    comments = models.TextField(
        max_length=1024,
        null=True,
        blank=True,
        verbose_name='项目申请经验'
    )
    summary = models.TextField(
        max_length=1024,
        null=True,
        blank=True,
        verbose_name='总结'
    )
    created_time = models.DateTimeField(
        auto_now_add=True,
        verbose_name='创建时间'
    )
    upvoted = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="research_upvoted_by",
        blank=True,
        verbose_name='点赞用户名单'
    )
    upvoted_count = models.PositiveIntegerField(
        default=0,
        verbose_name='点赞数'
    )
    
    def upvote(self, user):
        if self not in user.research_upvoted_by.all():
            user.research_upvoted_by.add(self)
            self.upvoted_count += 1
            self.save()
        else:
            raise IntegrityError
        
    def downvote(self, user):
        if self in user.research_upvoted_by.all():
            user.research_upvoted_by.remove(self)
            self.upvoted_count -= 1
            self.save()
        else:
            raise IntegrityError

    class Meta:
        verbose_name = '暑期研究经历'
        verbose_name_plural = verbose_name