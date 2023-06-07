FROM postgres:15.3

COPY src /docker-entrypoint-initdb.d/
