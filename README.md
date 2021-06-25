# Flyers-ustc

## Backend Usage

Database settings for development
```text
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'flyers',   
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
python manage.py migrate
python manage.py init_db
python manage.py runserver
```

Make migrations
```bash
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
python manage.py makemigrations
```
Register super user 
```shell
echo "from account.models import User; User.objects.create_superuser('flyers', '', 'flyers')" | python manage.py shell
```
`admin` site should be accessed with `/api/admin`. 


### Production
[docker-compose](https://docs.docker.com/compose/install/) and [docker](https://docs.docker.com/engine/install/) should be installed.
```
docker-compose build && docker-compose up
```

Postgresql database backup: [package](https://hub.docker.com/r/prodrigestivill/postgres-backup-local)