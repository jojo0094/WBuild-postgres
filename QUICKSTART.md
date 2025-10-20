# Quick Start Guide

Get up and running with WBuild-postgres in minutes!

## 🚀 Deploy to Railway (Fastest)

1. **Fork this repository** to your GitHub account
2. **Go to [Railway.app](https://railway.app/)** and sign in
3. **Click "New Project"** → "Deploy from GitHub repo"
4. **Select** your forked `WBuild-postgres` repository
5. **Done!** Railway will build and deploy automatically

Get your connection string from Railway dashboard → Connect tab.

## 🏠 Local Development

### Using Docker Compose (Recommended)

```bash
# Clone the repository
git clone https://github.com/jojo0094/WBuild-postgres.git
cd WBuild-postgres

# Copy environment file
cp .env.example .env

# Start PostgreSQL with PostGIS and pgRouting
docker-compose up -d

# Connect to the database
psql postgresql://postgres:postgres@localhost:5432/postgres
```

### Using Docker

```bash
# Build the image
docker build -t wbuild-postgres .

# Run the container
docker run -d \
  --name wbuild-postgres \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -p 5432:5432 \
  wbuild-postgres

# Connect
psql postgresql://postgres:mysecretpassword@localhost:5432/postgres
```

## ✅ Verify Extensions

Once connected to your database:

```sql
-- Check all extensions
SELECT extname, extversion FROM pg_extension;

-- Test PostGIS
SELECT PostGIS_Version();

-- Test pgRouting
SELECT pgr_version();

-- Create a spatial table
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    geom GEOMETRY(Point, 4326)
);
```

## 📝 Example Usage

```sql
-- Insert some locations
INSERT INTO locations (name, geom) VALUES
    ('New York', ST_SetSRID(ST_MakePoint(-74.0060, 40.7128), 4326)),
    ('Los Angeles', ST_SetSRID(ST_MakePoint(-118.2437, 34.0522), 4326)),
    ('Chicago', ST_SetSRID(ST_MakePoint(-87.6298, 41.8781), 4326));

-- Find locations within 100km of New York
SELECT name, 
       ST_Distance(
           geom::geography,
           ST_SetSRID(ST_MakePoint(-74.0060, 40.7128), 4326)::geography
       ) / 1000 AS distance_km
FROM locations
WHERE ST_DWithin(
    geom::geography,
    ST_SetSRID(ST_MakePoint(-74.0060, 40.7128), 4326)::geography,
    100000  -- 100km in meters
)
ORDER BY distance_km;
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file or set in Railway:

```bash
POSTGRES_PASSWORD=your_secure_password
POSTGRES_USER=postgres
POSTGRES_DB=postgres
POSTGRES_PORT=5432
```

### Connection String Format

```
postgresql://[user]:[password]@[host]:[port]/[database]
```

Example:
```
postgresql://postgres:mypassword@localhost:5432/postgres
```

## 📚 What's Included

- ✅ PostgreSQL 15
- ✅ PostGIS 3.3 (spatial database)
- ✅ pgRouting (routing/navigation)
- ✅ PostGIS Topology
- ✅ Auto-initialization scripts

## 🛠️ Troubleshooting

### Can't connect to database?

- Check if container is running: `docker ps`
- Check logs: `docker-compose logs postgres`
- Verify port 5432 is not in use: `lsof -i :5432`

### Extensions not available?

```sql
-- Manually create extensions if needed
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pgrouting;
```

### Need help?

- Check [README.md](README.md) for detailed documentation
- See [RAILWAY_DEPLOYMENT.md](RAILWAY_DEPLOYMENT.md) for Railway-specific help
- Open an issue on GitHub

## 📖 Next Steps

1. Read the [full README](README.md) for detailed usage
2. Check [RAILWAY_DEPLOYMENT.md](RAILWAY_DEPLOYMENT.md) for Railway tips
3. Explore PostGIS docs: https://postgis.net/documentation/
4. Learn pgRouting: https://docs.pgrouting.org/

---

**Happy routing! 🗺️**
