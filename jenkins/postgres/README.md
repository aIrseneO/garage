
```bash
sudo apt-get install -y postgresql-client

psql -U <username> -h <host> -d <database> -p 5432
psql -U jira -h <host_ip> -d jiradb

psql -U postgres -h <host_ip> -d postgresdb
\l
\c jiradb
\dt
select * from table_name;
select jira; \du;
```

# Reference
#   https://www.postgresql.org/docs/current/app-pg-isready.html
#   https://hub.docker.com/_/postgres