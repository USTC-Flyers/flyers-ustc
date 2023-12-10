from array import array

from django.conf import settings
from django.db import models
from django.utils import timezone

from discussion.managers.post import PostQuerySet
from django.core.cache import cache

class Post(models.Model):
    title = models.TextField(max_length=100)
    content = models.TextField()
    images = models.JSONField(default=array)
    comment_count = models.PositiveIntegerField(
        "comment count",
        default=0
    )

    visit_count = models.PositiveIntegerField(
        "visit count",
        default=0
    )
    liked = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="post_liked_by",
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
