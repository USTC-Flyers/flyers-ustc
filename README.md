# Flyers-ustc

## Backend Usage

```text
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'postgres',
        'USER': 'postgres',
        'PASSWORD': '666666',
        'HOST': '127.0.0.1',
        'PORT': '5432',
    }
}
```

```bash
cd backend
pip install -r requirements.txt 
python manage.py init_groups
python manage.py import_university
python manage.py runserver
```

TODO: dockerize and nginx serve