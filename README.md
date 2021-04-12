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

backend-API: http://0.0.0.0:5959/api/swagger/

### backend-API doc
[docker-compose](https://docs.docker.com/compose/install/) and [docker](https://docs.docker.com/engine/install/) should be installed.
```
docker-compose build && docker-compose up
```
