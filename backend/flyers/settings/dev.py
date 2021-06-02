from .base import *


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# Application definition

ALLOWED_HOSTS = ['*']

WEBPATH_PREFIX = 'http://47.96.42.162:8080'


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

CAS_VALIDATE_URL = 'http://passport.ustc.edu.cn/serviceValidate'
CAS_HOME_URL = 'http://home.ustc.edu.cn/~kelleykuang/cas/index.html?id=1'

# from deployment
try:
    from .local_settings import *
except ImportError:
    pass