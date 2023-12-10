from django.conf import settings
from django.db import models
from django.utils import timezone

from discussion.managers import CommentQuerySet


class Comment(models.Model):
    content = models.TextField()

    liked = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="comment_liked_by",
        blank=True
    )
    like_count = models.PositiveIntegerField(
        default=0
    )
    created_time = models.DateTimeField(
        default=timezone.now
    )
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name='user',
        on_delete=models.CASCADE
    )
    related_post = models.ForeignKey(
        'discussion.Post',
        related_name='post',
        on_delete=models.CASCADE
    )
    related_comment = models.ForeignKey(
        'self',
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
