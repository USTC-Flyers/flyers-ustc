from rest_framework import serializers

from admissions.serializers.admissions import UserInfoSerializer
from .. import models


class CommentSerializer(serializers.ModelSerializer):
    liked = serializers.SerializerMethodField(read_only=True)
    related_user = serializers.ReadOnlyField(source='discussion.comment.related_user')

    class Meta:
        model = models.Comment
        db_table = 't_comment'
        fields = '__all__'
        lookup_field = 'id'

    def get_liked(self, obj):
        user = self.context['request'].user
        res = user in obj.liked.all()
        return res

    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        if 'request' in self.context:
            request = self.context['request']
            if request.method == 'POST' and 'related_user' in request.data and request.data[
                'related_user'] != request.user.id:
                if raise_exception:
                    raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
                valid = False
        return valid


class CommentNestedSerializers(serializers.ModelSerializer):
    liked = serializers.SerializerMethodField(read_only=True)
    related_user = UserInfoSerializer()
    replies = serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = models.Comment
        db_table = 't_comment'
        fields = '__all__'
        lookup_field = 'id'

    def get_liked(self, obj):
        user = self.context['request'].user
        res = user in obj.liked.all()
        return res

    def get_replies(self, obj):
        return CommentNestedSerializers(obj.replies.all(), context={'request': self.context['request']},
                                        many=True).data

    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        request = self.context['request']
        if request.method == 'POST' and 'related_user' in request.data and request.data[
            'related_user'] != request.user.id:
            if raise_exception:
                raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
            valid = False
        return valid
