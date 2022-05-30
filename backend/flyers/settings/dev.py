import os

from .base import *


# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# Application definition

ALLOWED_HOSTS = ['*']

WEBPATH_PREFIX = 'http://47.96.42.162/login'

# Test 
# EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
# EMAIL_HOST = 'smtp.163.com'  
# EMAIL_PORT = 465
# SERVER_EMAIL = 'flyers_ustc@163.com'  
# EMAIL_HOST_USER = 'flyers_ustc@163.com'  
# # EMAIL_HOST_PASSWORD = '/-HMVcHC5r5Xt8j'  
# DEFAULT_FROM_EMAIL = EMAIL_HOST_USER
# EMAIL_HOST_PASSWORD = 'FLMUXXOJLAVXQIRL'  
# EMAIL_USE_SSL = True

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'flyers',
        'USER': 'postgres',
        'PASSWORD': 'password',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}


CAS_VALIDATE_URL = 'http://passport.ustc.edu.cn/serviceValidate'
CAS_HOME_URL = 'http://home.ustc.edu.cn/~ztl223/cas/index.html?id=1'

STATICFILES_DIRS = [os.path.join(BASE_DIR, '../../frontend/dist/static')]

TEMPLATE_DIR = os.path.join(BASE_DIR, '../../frontend/dist')

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [TEMPLATE_DIR],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]


# from deployment
try:
    from .local_settings import *
except ImportError:
    pass
