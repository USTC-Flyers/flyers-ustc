docker run --rm -v "$PWD:/backups" -u "$(id -u):$(id -g)" \
-e POSTGRES_HOST=postgres \
-e POSTGRES_DB=flyers \
-e POSTGRES_USER=postgres \
-e SCHEDULE="@daily" \
-e POSTGRES_PASSWORD=${POSTGRES_PASSWORD}  \
prodrigestivill/postgres-backup-local \
