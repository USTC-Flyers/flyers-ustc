from rest_framework import permissions

class IsOwnerOrReadOnly(permissions.BasePermission):
    
    def has_object_permission(self, request, view, obj):
        # Read permissions are allowed to any request,
        # so we'll always allow GET, HEAD or OPTIONS requests.
        if request.method in permissions.SAFE_METHODS:
            return True
        
        return obj.related_user == request.user
    
class IsWikiOwnerOrCannotValidate(permissions.BasePermission):
    
    def has_object_permission(self, request, view, obj):
        if obj.related_topic.group in request.user.groups.all():
            return True
        return False