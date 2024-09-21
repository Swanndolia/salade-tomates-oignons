FROM library/postgres
COPY salade_tomates_oignons_schema.sql /docker-entrypoint-initdb.d/
COPY salade_tomates_oignons_data.sql /docker-entrypoint-initdb.d/
EXPOSE 5432