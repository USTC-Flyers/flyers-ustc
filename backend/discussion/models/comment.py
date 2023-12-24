from django.conf import settings
from django.db import models
from django.utils import timezone

from discussion.managers import CommentQuerySet


class Comment(models.Model):
    class Meta:
        verbose_name = "评论"
        verbose_name_plural = "评论"

    content = models.TextField("评论内容")

    liked = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        verbose_name="喜欢用户",
        related_name="comment_liked_by",
        blank=True
    )
    like_count = models.PositiveIntegerField(
        "喜欢数量",
        default=0
    )
    created_time = models.DateTimeField(
        "创建时间",
        default=timezone.now
    )
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        verbose_name="评论用户",
        related_name='user',
        on_delete=models.CASCADE
    )
    related_post = models.ForeignKey(
        'discussion.Post',
        verbose_name="评论帖子",
        related_name='post',
        on_delete=models.CASCADE
    )
    related_comment = models.ForeignKey(
        'self',
        verbose_name="上级评论",
        null=True, blank=True,
        related_name='replies',
        on_delete=models.CASCADE
    )

    objects = CommentQuerySet.as_manager()

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
