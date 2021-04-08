from django.db import models
from django.conf import settings
from django.utils import timezone

class Notification(models.Model):
    UPDATED, UPVOTED, DELETED, APPROVED, REJECTED, REPLIED, MENTIONED, PINNED, UNPINNED, OTHER = range(10)
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
        (OTHER, "出bug了...")
    )
    related_user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        related_name='comment',
        on_delete=models.CASCADE
    )
    created_time = models.DateTimeField(
        default=timezone.now
    )
    ref_obj_name = models.CharField()
    ref_obj_id = models.IntegerField()
    display_text = models.TextField(
        default=__display_text
    )
    # for reasons
    more_text = models.TextField(
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
    
    def __display_text(self):
        return "您的" + self.ref_obj_name + self.OPERATIONS_CHOICES[self.operation][1]