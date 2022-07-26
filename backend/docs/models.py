from django.db import models
from mdeditor.fields import MDTextField


DOC_CHOICES = [
    ('doc', '文档'),
    ('todo', '待办'),
    ('list', '名单'),
    ('other', '其他'),
]


# Create your models here.
class Docs(models.Model):
    title = models.CharField(max_length=100, verbose_name='标题')
    created_at = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    updated_at = models.DateTimeField(auto_now=True, verbose_name='修改时间')
    doc_type = models.CharField(max_length=20, choices=DOC_CHOICES, default='doc', verbose_name='文档类型')
    content = MDTextField(verbose_name='内容')
    other_info = models.TextField(max_length=500, verbose_name='其他信息')

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = '文档'
        verbose_name_plural = verbose_name
