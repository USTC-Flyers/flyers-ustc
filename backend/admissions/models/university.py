from django.db import models

class University(models.Model):
    area = models.CharField(
        max_length=256,
        null=False,
        blank=False,
        verbose_name='区域'
    )
    school_name = models.CharField(
        max_length=256,
        null=False,
        blank=False,
        verbose_name='学校名'
    )
    school_name_cn = models.CharField(
        max_length=256,
        null=False,
        blank=False,
        verbose_name='学校中文名'
    )
    short_name = models.CharField(
        max_length=256,
        null=False,
        blank=False,
        verbose_name='学校简称'
    )

    def __str__(self):
        return '{}(id:{})'.format(self.school_name_cn, self.id)

    class Meta:
        verbose_name = '学校'
        verbose_name_plural = verbose_name
