FROM postgres:15.3

COPY ./migrations /docker-entrypoint-initdb.d/
