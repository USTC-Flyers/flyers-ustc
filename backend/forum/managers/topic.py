from django.db import models
from django.db.models import Q, Prefetch
from django.core.exceptions import ObjectDoesNotExist

fake_title = [
            {
                "category": "申请主线",
                "topics": [
                    {
                        "title": "选择多样性",
                        "id": 1
                    },
                    {
                        "title": "申请总体规划",
                        "id": 2
                    },
                    {
                        "title": "暑研",
                        "id": 3
                    },
                    {
                        "title": "套瓷",
                        "id": 4
                    },
                    {
                        "title": "CV、文书写作",
                        "id": 5
                    },
                    {
                        "title": "转专业申请",
                        "id": 6
                    },
                    {
                        "title": "国家/地区申请经验",
                        "id": 7
                    },
                    {
                        "title": "GAP",
                        "id": 8
                    }
                ]
            },
            {
                "category": "数学科学学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 9
                    }
                ]
            },
            {
                "category": "物理学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 10
                    }
                ]
            },
            {
                "category": "管理学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 11
                    }
                ]
            },
            {
                "category": "化学与材料科学学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 12
                    }
                ]
            },
            {
                "category": "生命科学学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 13
                    }
                ]
            },
            {
                "category": "地球和空间科学学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 14
                    }
                ]
            },
            {
                "category": "工程科学学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 15
                    }
                ]
            },
            {
                "category": "信息科学技术学院",
                "topics": [
                    {
                        "title": "申请经验",
                        "id": 16
                    }
                ]
            },
        ]

class TopicQuerySet(models.QuerySet):
    def public(self):
        return self.filter(is_valid=True)
    
    def user_followed(self, user):
        return self.filter(followed__contains=user)

    def meta(self):
        topics = self.public().select_related('current_version').order_by('id')
        meta_list = []
        meta_dict = {}
        for topic in topics:
            category = topic.group.name
            title = topic.current_version.title
            if category in meta_dict:
                meta_dict[category].append({
                    "title": title,
                    "id": topic.id
                })
            else:
                meta_dict[category] = [{
                    "title": title,
                    "id": topic.id
                }]
        
        for name, value in meta_dict.items():
            meta_list.append({
                "category": name,
                "topics": value
            })
        return meta_list
    
class TopicRevisionQuerySet(models.QuerySet):
    def user_history(self, pk):
        return self.filter(related_user_id=pk)
    
    def revision_set(self, pk):
        return self.all().filter(related_topic_id=pk) 
    
    def public(self):
        return self.filter(is_valid=True)