#!/bin/bash

# chmod +x backend/static

/wait-for-it.sh -t 120 postgres:5432
python manage.py migrate
python manage.py init_prod
gunicorn flyers.wsgi:application --bind 0.0.0.0:8000 --workers 2
# python manage.py runserver 0.0.0.0:8000 > log.txt 2>&1
# python -m debugpy --wait-for-client --listen 0.0.0.0:5678 manage.py runserver 0.0.0.0:8000 --nothreading --noreload