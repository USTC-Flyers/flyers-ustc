#!/bin/bash

# chmod +x backend/static

/wait-for-it.sh -t 120 postgres:5432
python manage.py migrate
# python manage.py init_prod
gunicorn flyers.wsgi:application --bind 0.0.0.0:8000 --workers 8