from django.contrib import admin
from django.utils.html import format_html

from discussion.models import Comment, Post


class PostAdmin(admin.ModelAdmin):
    list_display = ['id', 'title', 'show_nickname', 'content', 'display_images', 'visit_count', 'like_count',
                    'comment_count',
                    'created_time']
    search_fields = ['title']

    def show_nickname(self, obj):
        return obj.related_user.userprofile.nickname

    show_nickname.short_description = '昵称'

    def display_images(self, obj):
        if obj.images:
            image_tags = ''
            for image_url in obj.images:
                image_tags += f'<img src="{image_url}" style="max-width:100px; max-height:100px;"/>'
            return format_html(image_tags)
        else:
            return '无'

    display_images.short_description = '图片'


class CommentAdmin(admin.ModelAdmin):
    list_display = ['id', 'show_nickname', 'show_post_title', 'content', 'like_count', 'created_time']

    def show_post_title(self, obj):
        return obj.related_post.title

    show_post_title.short_description = '帖子'

    def show_nickname(self, obj):
        return obj.related_user.userprofile.nickname

    show_nickname.short_description = '昵称'


admin.site.register(Post, PostAdmin)
admin.site.register(Comment, CommentAdmin)
