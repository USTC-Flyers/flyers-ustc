from django.contrib.auth.models import AbstractUser, Group
from django.conf import settings
from urllib.request import urlopen
from urllib.parse import urlencode
from xml.etree import ElementTree
from django.db import models

# !TODO: add cas login
class User(AbstractUser):
    gid = models.CharField(max_length=255)
    
    def is_admin(self):
        try:
            g = self.groups.get(name='flyers-admin')
            return True
        except Group.DoesNotExist:
            return False
            
    @staticmethod
    def verify(ticket, service):
        gid, uid = User.check_ticket(ticket, service)
        user, created = User.objects.get_or_create(gid=gid, username=gid)
        return user, created
    
    @staticmethod
    def check_ticket(ticket, service):
        validate = (settings.CAS_VALIDATE_URL + "?" +
                    urlencode({"service": service, "ticket": ticket}))
        with urlopen(validate) as req:
            req_str = req.read()
            tree = ElementTree.fromstring(req_str)[0]
        cas = "{http://www.yale.edu/tp/cas}"
        if tree.tag == cas + "authenticationFailure":
            raise User.DoesNotExist
        print(req_str)
        gid = tree.find("attributes").find(cas + "gid").text.strip()
        uid = tree.find(cas + "user").text.strip()
        return gid, uid