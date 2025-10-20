-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Enable PostGIS Topology
CREATE EXTENSION IF NOT EXISTS postgis_topology;

-- Enable pgRouting extension
CREATE EXTENSION IF NOT EXISTS pgrouting;

-- Grant necessary permissions (optional, adjust as needed)
-- GRANT ALL PRIVILEGES ON DATABASE postgres TO your_user;
