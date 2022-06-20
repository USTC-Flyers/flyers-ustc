from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.utils.safestring import mark_safe
from django.db.models import Count
from .models import choice, User, UserProfile


class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['id', 'nickname', 'show_school', 'contact', 'is_verified', 'role', 'enrolledYear', 'isUndergrad', 'show_final_university', 'show_admission_num']
    list_filter = ['role', 'isUndergrad', 'school', 'enrolledYear', 'is_verified']

    exclude = ['id', 'related_user']
    search_fields = ['id', 'nickname', 'related_user__username', 'final_university__area', 'final_university__school_name', 'final_university__school_name_cn']

    def get_queryset(self, request):
        # def get_queryset(self, request):    for Django 1.6+
        qs = super(UserProfileAdmin, self).get_queryset(request)
        return qs.annotate(admissions_count=Count('related_user__admissions'))

    def show_admission_num(self, obj):
        return obj.related_user.admissions.count()

    def show_school(self, obj):
        if obj.school:
            return choice.school_list[obj.school]
        else:
            return mark_safe(
                '<span style="color: red;">未填写</span>'
            )

    def show_final_university(self, obj):
        if obj.final_university:
            # return obj.final_university.related_university
            return mark_safe('{}<br>({})'.format(obj.final_university.school_name_cn, obj.final_university.school_name))
        else:
            return mark_safe(
                '<span style="color: red;">暂无</span>'
            )

    show_admission_num.short_description = '已填写录取汇报数'
    show_admission_num.admin_order_field = 'admissions_count'
    show_school.short_description = '学院'
    show_final_university.short_description = '最终学校'

# Register your models here.
admin.site.register(User, UserAdmin)
admin.site.register(UserProfile, UserProfileAdmin)