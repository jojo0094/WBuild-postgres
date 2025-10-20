# Use official PostgreSQL image with PostGIS
FROM postgis/postgis:15-3.3

# Install pgRouting
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql-15-pgrouting \
    postgresql-15-pgrouting-scripts && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy initialization script
COPY init.sql /docker-entrypoint-initdb.d/

# Expose PostgreSQL port
EXPOSE 5432
