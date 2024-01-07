from rest_framework import serializers
from django.utils.html import strip_tags
from admissions.serializers.admissions import UserInfoSerializer
from .. import models
from bs4 import BeautifulSoup
import re

def extract_image_urls_from_html(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    img_tags = soup.find_all('img')
    image_urls = [img.get('src') for img in img_tags if img.get('src')]
    return image_urls

class PostSerializer(serializers.ModelSerializer):
    liked = serializers.SerializerMethodField(read_only=True)
    related_user = serializers.ReadOnlyField(source='discussion.post.related_user')
    class Meta:
        model = models.Post
        db_table = 't_post'
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

class PostNestedSerializers(serializers.ModelSerializer):
    liked = serializers.SerializerMethodField(read_only=True)
    summary = serializers.SerializerMethodField(read_only=True)
    related_user = UserInfoSerializer()
    images=serializers.SerializerMethodField(read_only=True)

    class Meta:
        model = models.Post
        db_table = 't_post'
        fields = '__all__'
        lookup_field = 'id'

    def get_liked(self, obj):
        user = self.context['request'].user
        res = user in obj.liked.all()
        return res
    def get_summary(self,obj):
        return strip_tags(obj.content)

    def get_images(self,obj):
        return extract_image_urls_from_html(obj.content)

    def is_valid(self, raise_exception=False):
        valid = super().is_valid(raise_exception=raise_exception)
        request = self.context['request']
        if request.method == 'POST' and 'related_user' in request.data and request.data[
            'related_user'] != request.user.id:
            if raise_exception:
                raise serializers.ValidationError({'related_user': '只允许创建本人信息哦'})
            valid = False
        return valid
