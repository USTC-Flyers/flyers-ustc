from django.db import models
from django.conf import settings
from django.utils import timezone
import os

def image_path(instance, filename):
    ext = os.path.splitext(filename)[1].lower()
    return os.path.join(
        'topic', 'image', str(instance.revision_number), 'pic' + ext)
    
def file_path(instance, filename):
    ext = os.path.splitext(filename)[1].lower()
    return os.path.join(
        'topic', 'file', str(instance.revision_number), 'file' + ext)

class TopicRevision(BaseRevisionMixin, models.Model):
    
    """This is where main revision data is stored. To make it easier to
    copy, do NEVER create m2m relationships."""
    author = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name='topic_revision_author',
        on_delete=models.CASCADE
    )
    related_topic = models.ForeignKey(
        "forum.topic", 
        on_delete=models.CASCADE
    )
    revision_number = models.IntegerField(
        editable=False, 
    )
    title = models.TextField(
        verbose_name="title",
        max_length=255,
    )
    # This is where the content goes, with whatever markup language is used
    content = models.TextField(
        blank=True
    )
    # !FIXME: migrate storage
    image = models.ImageField(
        upload_to=image_path,
        blank=True
    )
    file = models.FileField(
        upload_to=file_path,
        blank=True
    )
    is_deleted = models.BooleanField(
        default=False
    )
    created_time = models.DateTimeField(
        default=timezone.now
    )

    def __str__(self):
        return "%s (%d)" % (self.title, self.revision_number)

    def clean(self):
        # Enforce DOS line endings \r\n. It is the standard for web browsers,
        # but when revisions are created programatically, they might
        # have UNIX line endings \n instead.
        self.content = self.content.replace("\r", "").replace("\n", "\r\n")

    def inherit_predecessor(self, article):
        """
        Inherit certain properties from predecessor because it's very
        convenient. Remember to always call this method before
        setting properties :)"""
        predecessor = article.current_revision
        self.article = predecessor.article
        self.content = predecessor.content
        self.title = predecessor.title
        self.deleted = predecessor.deleted
        self.locked = predecessor.locked

    class Meta:
        get_latest_by = "revision_number"
        ordering = ("created_time",)
        unique_together = ("related_topic", "revision_number")

class Topic(models.Model):
    DEFAULT, PINNED, UNPINNED, CLOSED, UNCLOSED = range(5)
    ACTIONS_CHOICES = (
        (DEFAULT, "topic"),
        (PINNED, "topic pinned"),
        (UNPINNED, "topic unpinned"),
        (CLOSED, "topic closed"),
        (UNCLOSED, "topic unclosed")
    )
    # !FIXME: add group
    current_version = models.OneToOneField(
        "TopicRevision",
        on_delete=models.CASCADE,
        related_name="topic"
    )
    group = models.ForeignKey(
        settings.GROUP_MODEL,
        verbose_name="group",
        blank=True,
        null=True,
        help_text="Like in a UNIX file system, permissions can be given to a user according to group membership. Groups are handled through the Django auth system.",
        on_delete=models.SET_NULL,
    )
    action = models.IntegerField(
        choices=ACTIONS_CHOICES,
        default=DEFAULT,
    )
    view_count = models.PositiveIntegerField(
        "views count", 
        default=0
    )
    comment_count = models.PositiveIntegerField(
        "comment count", 
        default=0
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