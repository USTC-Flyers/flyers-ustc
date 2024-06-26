from django.db import models
from django.conf import settings
from django.utils import timezone
from ..managers.notification import NotificationQueryset

class Notification(models.Model):
    UPDATED, UPVOTED, DELETED, APPROVED, REJECTED, REPLIED, MENTIONED, PINNED, UNPINNED, PR, REPORT, OTHER, LIKED,COMMENT,COMMENT_LIKED, = range(15)
    OPERATIONS_CHOICES = (
        (UPDATED, "已更新"),
        (UPVOTED, "被点赞"),
        (DELETED, "被管理员删除"),
        (APPROVED, "审核通过"),
        (REJECTED, "审核未通过"),
        (REPLIED, "被回复"),
        (MENTIONED, "被提到"),
        (PINNED, "被管理员置顶"),
        (UNPINNED, "被管理员取消置顶"),
        (PR, "请求更改wiki"),
        (REPORT, "被举报"),
        (OTHER, "出bug了..."),
        (LIKED, "被喜欢"),
        (COMMENT, "被评论"),
        (COMMENT_LIKED, "评论被喜欢")
    )
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name='notification',
        on_delete=models.CASCADE
    )
    created_time = models.DateTimeField(
        default=timezone.now
    )
    ref_obj_name = models.CharField(
        max_length=255
    )
    ref_obj_id = models.IntegerField()
    # for reasons
    message = models.TextField(
        null=True,
        blank=True
    )
    is_read = models.BooleanField(
        default=False
    )
    operation = models.IntegerField(
        choices=OPERATIONS_CHOICES,
        default=OTHER
    )
    
    objects = NotificationQueryset.as_manager()
    
    def read(self):
        self.is_read = True
        self.save() 
        
    @property
    def get_message(self):
        if self.message is None:
            return "您的" + self.ref_obj_name + self.OPERATIONS_CHOICES[self.operation][1]
        return self.message
    
    @classmethod
    def notify(cls, comment, to_user, operation, **kwargs):
        cls.objects.create(
            related_user=to_user,
            ref_obj_name=comment.__class__.__name__,
            ref_obj_id=comment.id,
            operation=operation,
            is_read=False,
            **kwargs
        )
        print('[Notify] 您的' + comment.__class__.__name__ + cls.OPERATIONS_CHOICES[operation][1])
        
    @classmethod
    def notify_group(cls, comment, group, operation, **kwargs):
        for user in group:
            cls.notify(comment, user, operation, **kwargs)