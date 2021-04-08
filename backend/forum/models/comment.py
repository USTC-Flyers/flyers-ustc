from django.db import models
from django.conf import settings
from django.utils import timezone
from .topic import Topic

class CommentThread(models.Model):
    DEFAULT, PINNED, UNPINNED, CLOSED, UNCLOSED = range(5)
    ACTIONS_CHOICES = (
        (DEFAULT, "comment"),
        (PINNED, "comment pinned"),
        (UNPINNED, "comment unpinned"),
        (CLOSED, "topic closed"),
        (UNCLOSED, "topic unclosed")
    )
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name='comment_thread',
        on_delete=models.CASCADE
    )
    related_topic = models.ForeignKey(
        Topic, 
        related_name="comment_related_topic",
        on_delete=models.CASCADE
    )
    content = models.TextField(
        max_length=500
    )
    action = models.IntegerField(
        choices=ACTIONS_CHOICES,
        default=DEFAULT
    )
    created_time = models.DateTimeField(
        default=timezone.now
    )
    
class Comment(models.Model):
    DEFAULT, PINNED, UNPINNED, CLOSED, UNCLOSED = range(5)
    ACTIONS_CHOICES = (
        (DEFAULT, "comment"),
        (PINNED, "comment pinned"),
        (UNPINNED, "comment unpinned"),
        (CLOSED, "topic closed"),
        (UNCLOSED, "topic unclosed")
    )
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name='comment',
        on_delete=models.CASCADE
    )
    related_comment_thread = models.ForeignKey(
        CommentThread, 
        related_name="comment",
        on_delete=models.CASCADE
    )
    content = models.TextField(
        max_length=500
    )
    action = models.IntegerField(
        choices=ACTIONS_CHOICES,
        default=DEFAULT
    )
    created_time = models.DateTimeField(
        default=timezone.now
    )
    upvoted = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="topic_upvoted_by",
        null=True,
        blank=True
    )
    upvoted_count = models.PositiveIntegerField(
        default=0
    )