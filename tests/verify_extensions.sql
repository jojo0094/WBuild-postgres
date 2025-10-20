-- Verification script for PostgreSQL extensions
-- Run this after the database is set up to verify all extensions are working

-- Check if PostGIS extension is installed
SELECT 'PostGIS installed: ' || CASE WHEN EXISTS (
    SELECT 1 FROM pg_extension WHERE extname = 'postgis'
) THEN 'YES' ELSE 'NO' END AS status;

-- Check PostGIS version
SELECT 'PostGIS version: ' || PostGIS_Version() AS version;

-- Check if PostGIS Topology extension is installed
SELECT 'PostGIS Topology installed: ' || CASE WHEN EXISTS (
    SELECT 1 FROM pg_extension WHERE extname = 'postgis_topology'
) THEN 'YES' ELSE 'NO' END AS status;

-- Check if pgRouting extension is installed
SELECT 'pgRouting installed: ' || CASE WHEN EXISTS (
    SELECT 1 FROM pg_extension WHERE extname = 'pgrouting'
) THEN 'YES' ELSE 'NO' END AS status;

-- Check pgRouting version
SELECT 'pgRouting version: ' || pgr_version() AS version;

-- List all installed extensions
SELECT 'All installed extensions:' AS info;
SELECT extname AS extension_name, extversion AS version 
FROM pg_extension 
ORDER BY extname;

-- Test PostGIS functionality with a simple spatial query
SELECT 'Testing PostGIS functionality...' AS info;
SELECT ST_AsText(ST_SetSRID(ST_MakePoint(-74.0060, 40.7128), 4326)) AS test_point;

-- Test pgRouting functionality (basic function check)
SELECT 'Testing pgRouting functionality...' AS info;
SELECT pgr_version() AS pgrouting_version;
