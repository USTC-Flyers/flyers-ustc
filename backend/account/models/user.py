from django.contrib.auth.models import AbstractUser
from django.conf import settings
from urllib.request import urlopen
from urllib.parse import urlencode
from xml.etree import ElementTree
from django.db import models

# !TODO: add cas login
class User(AbstractUser):
    id = models.CharField(max_length=255, primary_key=True)
    
    @staticmethod
    def verify(ticket, service):
        id, uid = User.check_ticket(ticket, service)
        user, created = User.objects.get_or_create(id=id, username=id)
        return user, created
    
    @staticmethod
    def check_ticket(ticket, service):
        validate = (settings.CAS_VALIDATE_URL + "?" +
                    urlencode({"service": service, "ticket": ticket}))
        with urlopen(validate) as req:
            tree = ElementTree.fromstring(req.read())[0]
        cas = "{http://www.yale.edu/tp/cas}"
        if tree.tag == cas + "authenticationFailure":
            raise User.DoesNotExist
        print('authenticationSuccess!')
        gid = tree.find("attributes").find(cas + "gid").text.strip()
        uid = tree.find(cas + "user").text.strip()
        return gid, uid