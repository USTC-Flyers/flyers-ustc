from django.conf import settings
from django.db import models
from .choice import Choices
from django.contrib.postgres.fields import ArrayField
from django.db.utils import IntegrityError

class Background(models.Model):
    related_user = models.OneToOneField(
        settings.AUTH_USER_MODEL, 
        verbose_name="用户",
        related_name="background", 
        on_delete=models.CASCADE,
        null=False,
        blank=False
    )
    major = models.CharField(
        choices=Choices.MAJORCHOICES,
        verbose_name='专业',
        editable=True,
        null=True,
        max_length=255
    )
    gpa = models.FloatField(
        null=True,
        verbose_name='绩点',
        blank=True
    )
    rank = models.CharField(
        choices=Choices.RANKCHOICES,
        verbose_name='排名',
        null=True,
        blank=True,
        max_length=255
    )
    apply_for = models.CharField(
        choices=Choices.APPLYFORCHOICES,
        verbose_name='申请学位',
        null=True,
        blank=True,
        max_length=255
    )
    TOEFL = models.CharField(
        max_length=255,
        verbose_name='TOEFL',
        null=True, 
        blank=True
    )
    GRE = models.CharField(
        max_length=256,
        verbose_name='GRE',
        null=True, 
        blank=True
    )
    score = models.CharField(
        max_length=256,
        verbose_name='其他分数',
        null=True, 
        blank=True
    )
    researchSpec = models.TextField(
        max_length=1024,
        verbose_name='科研经历',
        null=True,
        blank=True
    )
    referSpec = models.TextField(
        max_length=1024,
        verbose_name='推荐信',
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
        blank=True,
        verbose_name='申请方向思考'
    )
    summary = models.TextField(
        null=True,
        blank=True,
        verbose_name='申请感言'
    )
    upvoted = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="background_upvoted_by",
        null=True,
        verbose_name='点赞人',
        blank=True
    )
    upvoted_count = models.PositiveIntegerField(
        default=0,
        verbose_name='点赞数'
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

    def __str__(self):
        return '经历(id: {})'.format(self.id)

    class Meta:
        verbose_name = '经历'
        verbose_name_plural = verbose_name
