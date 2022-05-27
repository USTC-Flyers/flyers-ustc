#!/bin/bash

# chmod +x backend/static

# database migrate
./wait-for-it.sh -t 120 database:5432

cp -r /app/backend/static/* /app/backend/static_output/
python manage.py makemigrations
python manage.py migrate

# python manage.py init_prod
gunicorn flyers.wsgi:application --bind 0.0.0.0:8000 --workers 4