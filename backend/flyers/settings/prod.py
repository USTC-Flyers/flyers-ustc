"""
Django settings for flyers project.

Generated by 'django-admin startproject' using Django 3.1.7.

For more information on this file, see
https://docs.djangoproject.com/en/3.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.1/ref/settings/
"""
from .base import *
from pathlib import Path
import datetime
import os

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'lg#ulucdtykg$w7frf#i9u$zp(adqexs9)12x$sv#xerxy4h5@'

OSS_ENDPOINT = 'https://oss-cn-hongkong.aliyuncs.com'
OSS_ACCESS_KEY_ID='LTAI5tKv5A47zQ1WAVknsbZd'
OSS_ACCESS_KEY_SECRET='kQijoOm6RPBVfviwkLaUlDJ2ufNM75'

EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.163.com'
EMAIL_PORT = 465
SERVER_EMAIL = 'flyers_ustc@163.com'
EMAIL_HOST_USER = 'flyers_ustc@163.com'
# EMAIL_HOST_PASSWORD = '/-HMVcHC5r5Xt8j'  
DEFAULT_FROM_EMAIL = EMAIL_HOST_USER
EMAIL_HOST_PASSWORD = 'FLMUXXOJLAVXQIRL'
EMAIL_USE_SSL = True
ADMINS = [('Feiyue', 'flyers_ustc@163.com')]

# Create empty logging file if not exist

INFO_LOG_PATH = "/app/backend/logs/info.log"
ERROR_LOG_PATH = "/app/backend/logs/error.log"
if not os.path.exists(INFO_LOG_PATH):
    try:
        with open(INFO_LOG_PATH, 'w'):
            pass
    except Exception:
        pass

if not os.path.exists(ERROR_LOG_PATH):
    try:
        with open(ERROR_LOG_PATH, 'w'):
            pass
    except Exception:
        pass


# Logging
# https://www.agiliq.com/blog/2017/12/configure-django-log-exceptions-production/
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'filters': {
        'require_debug_false': {
            '()': 'django.utils.log.RequireDebugFalse',
        },
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    'formatters': {
        'django.server': {
            '()': 'django.utils.log.ServerFormatter',
            'format': '[%(server_time)s] %(message)s',
        },
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(lineno)s %(message)s'
        },
    },
    'handlers': {
        'console': {
            'level': 'INFO',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
        },
        'console_debug_false': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'logging.StreamHandler',
        },
        'info_file': {
            'level': 'INFO',
            'class': 'logging.FileHandler',
            'filters': ['require_debug_false'],
            'filename': "/app/backend/logs/info.log",
            'formatter': 'verbose',
            'encoding': 'utf-8'
        },
        'error_file': {
            'level': 'ERROR',
            'class': 'logging.FileHandler',
            'filters': ['require_debug_false'],
            'filename': "/app/backend/logs/error.log",
            'formatter': 'verbose',
            'encoding': 'utf-8'
        },
        'django.server': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'django.server',
        },
        'mail_admins': {
            'level': 'ERROR',
            'filters': ['require_debug_false'],
            'class': 'django.utils.log.AdminEmailHandler'
        }
    },
    'loggers': {
        'django': {
            'handlers': ['console', 'console_debug_false', 'mail_admins'],
            'level': 'INFO',
        },
        'django.server': {
            'handlers': ['django.server'],
            'level': 'INFO',
            'propagate': False,
        }
    }
}

# SECURITY WARNING: don't run with debug turned on in production!
# !FIXME
DEBUG = False

# TODO
ALLOWED_HOSTS = ['localhost', 'ustcflyer.com', 'ustcflyer', '127.0.0.1']

# Application definition

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
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

WSGI_APPLICATION = 'flyers.wsgi.application'

# Database
# https://docs.djangoproject.com/en/3.1/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.environ.get("POSTGRES_DB"),
        'USER': os.environ.get("POSTGRES_USER"),
        'PASSWORD': os.environ.get("POSTGRES_PWD"),
        'HOST': os.environ.get("POSTGRES_HOST"),
        'PORT': '5432',
    }
}

# Password validation
# https://docs.djangoproject.com/en/3.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]

AUTH_USER_MODEL = 'account.User'

GROUP_MODEL = 'auth.group'

SIMPLE_JWT = {
    'ACCESS_TOKEN_LIFETIME': timedelta(days=1),
    'REFRESH_TOKEN_LIFETIME': timedelta(days=10),
    'AUTH_HEADER_TYPES': ('Bearer',)
}

# Internationalization
# https://docs.djangoproject.com/en/3.1/topics/i18n/

LANGUAGE_CODE = 'zh-hans'

TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True

WEBPATH_PREFIX = 'https://www.ustcflyer.com/login'

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.1/howto/static-files/

STATIC_ROOT = '/app/backend/static'

MEDIA_ROOT = '/app/backend/media/mdeditor'

CAS_SERVER_URL = 'https://home.ustc.edu.cn/~ztl223/cas/index.html?id=1'
# CAS_VALIDATE_URL = 'http://passport.ustc.edu.cn/serviceValidate'
CAS_VALIDATE_URL = 'https://sso-proxy.lug.ustc.edu.cn/auth/default/validate'
CAS_HOME_URL = 'http://home.ustc.edu.cn/~ztl223/cas/index.html?id=1'
CAS_SERVER_URL = 'https://home.ustc.edu.cn/~ztl223/cas/index.html?id=1'

CAS_VERSION = '2'
CAS_APPLY_ATTRIBUTES_TO_USER = True
SUCCESS_SSO_AUTH_REDIRECT = ''
CAS_CREATE_USER = True
