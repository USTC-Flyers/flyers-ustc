from array import array

from django.conf import settings
from django.contrib.postgres.indexes import GinIndex
from django.db import models
from django.utils import timezone

from discussion.managers.post import PostQuerySet
from django.core.cache import cache


class Post(models.Model):
    class Meta:
        verbose_name = "帖子"
        verbose_name_plural = "帖子"
        indexes = [
            GinIndex(fields=['title', 'content'], name='post_search_idx')
        ]

    title = models.TextField(max_length=100, verbose_name="标题")
    content = models.TextField(verbose_name="内容")
    images = models.JSONField("图片", default=list,blank=True)
    comment_count = models.PositiveIntegerField(
        "评论量",
        default=0
    )

    visit_count = models.PositiveIntegerField(
        "浏览量",
        default=0
    )
    liked = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="post_liked_by",
        verbose_name="喜欢用户",
        blank=True
    )
    like_count = models.PositiveIntegerField(
        "喜欢量",
        default=0
    )
    created_time = models.DateTimeField(
        "创建时间",
        default=timezone.now
    )
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        verbose_name="发贴用户",
        related_name='discussion_post',
        on_delete=models.CASCADE
    )

    objects = PostQuerySet.as_manager()

    def get_liked(self):
        user = self.context['request']
        return user in self.liked.all()

    def like(self, user):
        if user not in self.liked.all():
            self.liked.add(user)
            self.like_count += 1
            self.save()

    def cancel_like(self, user):
        if user in self.liked.all():
            self.liked.remove(user)
            self.like_count -= 1
            self.save()

    def visit(self):
        cache_key = f'visit_discussion_post_{self.id}_{self.related_user_id}'
        if cache.get(cache_key) is None:
            cache.set(cache_key, '', timeout=60 * 60)
            self.visit_count += 1
            self.save()
