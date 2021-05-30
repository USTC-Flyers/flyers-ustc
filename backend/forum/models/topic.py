from django.db import models
from django.conf import settings
from django.utils import timezone
import os
from ..managers.topic import TopicQuerySet, TopicRevisionQuerySet
from hitcount.models import HitCountMixin, HitCount
from django.contrib.contenttypes.fields import GenericRelation

def image_path(instance, filename):
    ext = os.path.splitext(filename)[1].lower()
    return os.path.join(
        'topic', 'image', str(instance.revision_number), 'pic' + ext)
    
def file_path(instance, filename):
    ext = os.path.splitext(filename)[1].lower()
    return os.path.join(
        'topic', 'file', str(instance.revision_number), 'file' + ext)

class TopicRevision(models.Model, HitCountMixin):
    
    """This is where main revision data is stored. To make it easier to
    copy, do NEVER create m2m relationships."""
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name='topic_revision',
        on_delete=models.CASCADE
    )
    related_topic = models.ForeignKey(
        "Topic", 
        on_delete=models.CASCADE,
        related_name="topic_revision",
        null=True,
        blank=True
    )
    revision_number = models.IntegerField()
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
    created_time = models.DateTimeField(
        default=timezone.now
    )
    is_valid = models.BooleanField(
        default=False
    )
    
    objects = TopicRevisionQuerySet.as_manager()

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
        ordering = ("-created_time",)
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
        related_name="topic",
        null=True,
        blank=True
    )
    group = models.ForeignKey(
        settings.GROUP_MODEL,
        verbose_name="group",
        blank=True,
        null=True,
        help_text="Like in a UNIX file system, permissions can be given to a user according to group membership. Groups are handled through the Django auth system.",
        on_delete=models.SET_NULL,
    )
    followed = models.ManyToManyField(
        settings.AUTH_USER_MODEL,
        related_name="topic_followed_by",
        blank=True,
        null=True
    )
    followed_count = models.PositiveIntegerField(
        default=0
    )
    action = models.IntegerField(
        choices=ACTIONS_CHOICES,
        default=DEFAULT,
    )
    hit_count = models.PositiveIntegerField(
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
    is_valid = models.BooleanField(
        default=False
    )
    
    objects = TopicQuerySet.as_manager()

    def set_valid_and_update(self, new_revision):
        if self.current_version is None or self.current_version.revision_number < new_revision.revision_number:
            self.current_version = new_revision
            self.is_valid = True
            new_revision.is_valid = True
            self.save()
            new_revision.save()
            return True
        return False
    
    def get_followed(self):
        user = self.context['request']
        return user in self.followed.all()
    
    def get_upvote(self):
        user = self.context['request']
        return user in self.upvoted.all()
        
    def follow(self, user):
        if user not in self.followed.all():
            self.followed.add(user)
            self.followed_count += 1
            self.save()
            
    def unfollow(self, user):
        if user in self.followed.all():
            self.followed.add(user)
            self.followed_count -= 1
            self.save()
            
    def increase_comment_thread_count(self):
        self.comment_count += 1
        self.save()
    
    def decrease_comment_thread_count(self):
        self.comment_count -= 1
        self.save()
        
    def pin(self):
        self.action = self.PINNED
        self.save()
    
    def unpin(self):
        self.action = self.UNPINNED
        self.save()
        
    def upvote(self, user):
        if self not in user.topic_upvoted_by.all():
            user.topic_upvoted_by.add(self)
            self.upvoted_count += 1
            self.save()
        
    def downvote(self, user):
        if self in user.topic_upvoted_by.all():
            user.topic_upvoted_by.remove(self)
            self.upvoted_count -= 1
            self.save()
            
    def visit(self):
        self.hit_count += 1
        self.save()