# WBuild-postgres

PostgreSQL database template with PostGIS and pgRouting extensions, optimized for Railway deployment.

## Features

- PostgreSQL 15
- PostGIS 3.3 (spatial database extender)
- pgRouting (routing functionality)
- Pre-configured for Railway.app deployment

## Extensions Included

- **postgis** - Spatial database capabilities
- **postgis_topology** - Topology support for PostGIS
- **pgrouting** - Routing and network analysis functionality

## Deployment to Railway

### Option 1: Deploy from GitHub

1. Fork this repository
2. Go to [Railway.app](https://railway.app/)
3. Click "New Project"
4. Select "Deploy from GitHub repo"
5. Choose your forked repository
6. Railway will automatically detect the Dockerfile and deploy

### Option 2: Using Railway CLI

```bash
# Install Railway CLI
npm i -g @railway/cli

# Login to Railway
railway login

# Initialize project
railway init

# Deploy
railway up
```

## Local Development

### Using Docker

```bash
# Build the image
docker build -t wbuild-postgres .

# Run the container
docker run -d \
  --name wbuild-postgres \
  -e POSTGRES_PASSWORD=yourpassword \
  -e POSTGRES_DB=yourdatabase \
  -p 5432:5432 \
  wbuild-postgres
```

### Using Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'
services:
  postgres:
    build: .
    environment:
      POSTGRES_PASSWORD: yourpassword
      POSTGRES_DB: yourdatabase
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
```

Then run:

```bash
docker-compose up -d
```

## Verify Extensions

Connect to your database and verify the extensions are installed:

```sql
-- List installed extensions
SELECT * FROM pg_extension;

-- Check PostGIS version
SELECT PostGIS_Version();

-- Check pgRouting version
SELECT pgr_version();
```

## Environment Variables

The following environment variables can be configured:

- `POSTGRES_PASSWORD` - Database password (required)
- `POSTGRES_USER` - Database user (default: postgres)
- `POSTGRES_DB` - Database name (default: postgres)

## Usage Example

```sql
-- Create a table with geometry
CREATE TABLE cities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    location GEOMETRY(Point, 4326)
);

-- Insert sample data
INSERT INTO cities (name, location) 
VALUES ('New York', ST_SetSRID(ST_MakePoint(-74.0060, 40.7128), 4326));

-- Query using spatial functions
SELECT name, ST_AsText(location) 
FROM cities 
WHERE ST_DWithin(
    location, 
    ST_SetSRID(ST_MakePoint(-74.0060, 40.7128), 4326)::geography,
    10000  -- 10km radius
);
```

## Contributing

Feel free to open issues or submit pull requests for improvements.

## License

MIT
