#!/bin/bash

# chmod +x backend/static

/wait-for-it.sh -t 120 postgres:5432
python manage.py migrate
python manage.py init_db
# gunicorn flyers.wsgi:application --bind 0.0.0.0:8000 --workers 2
python manage.py runserver 0.0.0.0:8000 > log.txt