python3 -c "import secrets; print('POSTGRES_PASSWORD=%s\n' % secrets.token_hex(32));" >> .env
mkdir -p /var/opt/pgbackups && chown -R 999:999 /var/opt/pgbackups
docker-compose down && docker-compose build
docker volume rm $(docker volume ls -q)
docker-compose up -d