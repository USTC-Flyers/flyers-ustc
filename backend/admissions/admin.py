from django.contrib import admin
from .models import Admissions, Background


# Register your models here.
class AdmissionsAdmin(admin.ModelAdmin):
    list_display = ['id', 'show_nickname', 'related_program', 'related_university', 'show_bg_researchSpec', 'show_bg_referSpec', 'result', 'enrolledSemester', 'created_time', 'comments', 'summary', 'show_bg_comments', 'show_bg_summary']
    list_filter = ['result', 'enrolledSemester']
    list_per_page = 10

    date_hierarchy = 'created_time'

    def show_nickname(self, obj):
        return obj.related_user.userprofile.nickname

    def show_bg_researchSpec(self, obj):
        return obj.related_background.researchSpec

    def show_bg_referSpec(self, obj):
        return obj.related_background.referSpec

    def show_bg_comments(self, obj):
        return obj.related_background.comments

    def show_bg_summary(self, obj):
        return obj.related_background.summary

    show_bg_researchSpec.short_description = '科研经历'
    show_bg_referSpec.short_description = '推荐信'
    show_bg_summary.short_description = '申请方向思考'
    show_bg_comments.short_description = '申请感言'
    show_nickname.short_description = '昵称'


class BackgroundAdmin(admin.ModelAdmin):
    list_display = ['id', 'show_nickname', 'upvoted_count', 'major', 'gpa', 'rank', 'apply_for', 'TOEFL', 'GRE', 'score', 'researchSpec', 'referSpec', 'comments', 'summary']
    list_filter = ['apply_for', 'major']

    exclude = ['related_user']

    def show_nickname(self, obj):
        return obj.related_user.userprofile.nickname

    show_nickname.short_description = '昵称'


admin.site.register(Admissions, AdmissionsAdmin)
admin.site.register(Background, BackgroundAdmin)
