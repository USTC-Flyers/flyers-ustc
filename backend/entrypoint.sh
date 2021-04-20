#!/bin/bash

# chmod +x backend/static

/wait-for-it.sh -t 120 postgres:5432
python manage.py migrate
python manage.py init_groups
python manage.py import_university
# for debug
echo "from account.models import User; User.objects.create_superuser('test', '', 'test')" | python manage.py shell
gunicorn flyers.wsgi:application --bind 0.0.0.0:8000--workers 2