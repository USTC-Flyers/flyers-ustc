from django.contrib import admin
from .models import Docs


# Register your models here.
class DocsAdmin(admin.ModelAdmin):
    list_display = ['id', 'title', 'doc_type', 'created_at', 'updated_at']
    list_filter = ['doc_type']
    list_per_page = 10
    list_editable = ['title', 'doc_type']
    search_fields = ['title', 'other_info', 'content']
    date_hierarchy = 'created_at'


admin.site.register(Docs, DocsAdmin)
