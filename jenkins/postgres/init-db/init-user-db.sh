#!/bin/bash
set -e

echo "Running init-user-db.sh..."

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

	CREATE USER jira WITH PASSWORD 'password';
	CREATE DATABASE jiradb WITH ENCODING=‘UTF8’ OWNER=jira;
	GRANT ALL PRIVILEGES ON DATABASE jiradb TO jira;

EOSQL

echo "Database and user created successfully."
