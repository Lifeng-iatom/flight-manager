#!/bin/bash



# Create the database if it doesn't exist and import the dump file
mysql -u $MYSQL_USER --password=$MYSQL_PASSWORD<<EOF
  CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
  USE $MYSQL_DATABASE;
  SOURCE /docker-entrypoint-initdb.d/exampledb_dump.sql;
EOF

echo "Initialization completed."
