from .base import *


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []


# Application definition

ALLOWED_HOSTS = ['*']


DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'flyers',
        'USER': 'postgres',
        'PASSWORD': '666666',
        'HOST': '0.0.0.0',
        'PORT': '5432',
    }
}

CAS_VALIDATE_URL = 'https://passport.ustc.edu.cn/serviceValidate'

# from deployment
try:
    from .local_settings import *
except ImportError:
    pass