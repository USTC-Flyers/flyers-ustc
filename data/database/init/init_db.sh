psql -U ${POSTGRES_USER} -c "CREATE EXTENSION pg_trgm;" ${POSTGRES_DB}
psql -U ${POSTGRES_USER} -c "CREATE EXTENSION pg_trgm;" postgres