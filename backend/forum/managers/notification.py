from django.db import models

class NotificationQueryset(models.QuerySet):
    def read(self, user):
        # returns updated rows count (int)
        return (
            self.filter(user=user)
            .update(is_read=True)
        )