#!/bin/sh
set -e
echo "Waiting for database..."
until mysqladmin ping -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" --silent --ssl=0; do
  echo "DB not ready, waiting..."
  sleep 2
done
echo "DB is ready"
exec "$@"