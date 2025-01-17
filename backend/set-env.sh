#!/bin/sh
if [ -r /run/secrets/db-password ]; then
  export MYSQL_PASSWORD=$(cat /run/secrets/db-password)
else
  echo "Error: /run/secrets/db-password file not found or not readable"
  exit 1
fi

exec "$@"