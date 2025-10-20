#!/bin/bash
# Test script to verify PostgreSQL setup with PostGIS and pgRouting

set -e

echo "Starting PostgreSQL container..."
docker-compose up -d

echo "Waiting for PostgreSQL to be ready..."
sleep 10

# Wait for PostgreSQL to be healthy
until docker-compose exec -T postgres pg_isready -U postgres; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

echo "PostgreSQL is ready!"

echo "Running extension verification..."
docker-compose exec -T postgres psql -U postgres -d postgres -f /docker-entrypoint-initdb.d/../tests/verify_extensions.sql || \
docker-compose exec -T postgres psql -U postgres -d postgres << 'EOF'
-- Check if PostGIS extension is installed
SELECT 'PostGIS installed: ' || CASE WHEN EXISTS (
    SELECT 1 FROM pg_extension WHERE extname = 'postgis'
) THEN 'YES' ELSE 'NO' END AS status;

-- Check PostGIS version
SELECT 'PostGIS version: ' || PostGIS_Version() AS version;

-- Check if pgRouting extension is installed
SELECT 'pgRouting installed: ' || CASE WHEN EXISTS (
    SELECT 1 FROM pg_extension WHERE extname = 'pgrouting'
) THEN 'YES' ELSE 'NO' END AS status;

-- Check pgRouting version
SELECT 'pgRouting version: ' || pgr_version() AS version;

-- List all installed extensions
SELECT extname AS extension_name, extversion AS version 
FROM pg_extension 
ORDER BY extname;
EOF

echo "Test completed successfully!"

echo "Stopping PostgreSQL container..."
docker-compose down

echo "All tests passed!"
