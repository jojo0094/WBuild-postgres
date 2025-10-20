# Railway Deployment Guide

This guide provides detailed instructions for deploying WBuild-postgres on Railway.app.

## Prerequisites

- A Railway account ([Sign up here](https://railway.app/))
- This repository forked or available on GitHub

## Quick Deploy

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/postgres)

## Step-by-Step Deployment

### 1. Create a New Project

1. Log in to [Railway.app](https://railway.app/)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Authorize Railway to access your GitHub account if needed
5. Select the `WBuild-postgres` repository

### 2. Configure Environment Variables

Railway will automatically detect the Dockerfile and start building. You may want to configure:

- `POSTGRES_PASSWORD` - Set a secure password (Railway can generate one)
- `POSTGRES_USER` - Database user (default: postgres)
- `POSTGRES_DB` - Database name (default: postgres)

### 3. Wait for Deployment

Railway will:
1. Build the Docker image
2. Install PostgreSQL with PostGIS
3. Install pgRouting
4. Run the initialization script
5. Deploy your database

This process typically takes 2-5 minutes.

### 4. Get Connection Details

After deployment:

1. Click on your service
2. Go to the "Connect" tab
3. Copy the connection string or individual credentials

Connection string format:
```
postgresql://[user]:[password]@[host]:[port]/[database]
```

### 5. Verify Extensions

Connect to your database and verify extensions:

```sql
-- List all extensions
SELECT * FROM pg_extension;

-- Check PostGIS
SELECT PostGIS_Version();

-- Check pgRouting
SELECT pgr_version();
```

## Connecting to Your Database

### Using psql

```bash
psql "postgresql://user:password@host:port/database"
```

### Using Python (psycopg2)

```python
import psycopg2

conn = psycopg2.connect(
    host="your-host.railway.app",
    port=5432,
    database="railway",
    user="postgres",
    password="your-password"
)
```

### Using Node.js (pg)

```javascript
const { Client } = require('pg');

const client = new Client({
  host: 'your-host.railway.app',
  port: 5432,
  database: 'railway',
  user: 'postgres',
  password: 'your-password',
});

await client.connect();
```

## Railway-Specific Features

### Automatic Backups

Railway provides automatic backups. Configure them in your project settings.

### Scaling

Railway allows you to scale your database resources:
1. Go to your service settings
2. Adjust memory and CPU allocations
3. Railway will restart your service with new resources

### Monitoring

Railway provides built-in monitoring:
- CPU usage
- Memory usage
- Network traffic
- Deployment logs

Access these from your service dashboard.

## Troubleshooting

### Build Fails

If the build fails:
1. Check the build logs in Railway
2. Ensure all files are committed to your repository
3. Verify the Dockerfile syntax

### Connection Issues

If you can't connect:
1. Verify your credentials
2. Check if the service is running
3. Ensure your IP is not blocked (Railway uses allowlists)

### Extensions Not Working

If extensions are not installed:
1. Check deployment logs
2. Verify `init.sql` was copied correctly
3. Manually run the extension creation commands

## Cost Considerations

Railway pricing is based on:
- Compute time (vCPU hours)
- Memory usage
- Network egress

Free tier includes:
- $5 of usage per month
- Suitable for development and testing

See [Railway Pricing](https://railway.app/pricing) for details.

## Best Practices

1. **Use Environment Variables**: Never hardcode credentials
2. **Regular Backups**: Enable automatic backups
3. **Monitor Usage**: Keep track of your resource consumption
4. **Security**: Use strong passwords and limit access
5. **Updates**: Keep your PostgreSQL and extensions up to date

## Support

- Railway Discord: [discord.gg/railway](https://discord.gg/railway)
- Railway Docs: [docs.railway.app](https://docs.railway.app)
- GitHub Issues: Report issues on this repository

## Advanced Configuration

### Custom Init Scripts

Add more SQL scripts to initialize your database:

1. Create additional `.sql` files
2. Copy them to `/docker-entrypoint-initdb.d/` in the Dockerfile
3. Scripts run in alphabetical order

### Volume Persistence

Railway automatically persists your database data. No additional configuration needed.

### Health Checks

Railway monitors your service health automatically. The database is considered healthy when:
- PostgreSQL accepts connections
- Extensions are loaded successfully

## Migration from Other Platforms

### From Heroku

1. Export your Heroku database: `heroku pg:backups:capture`
2. Download the backup: `heroku pg:backups:download`
3. Restore to Railway: `psql [railway-connection-string] < latest.dump`

### From AWS RDS

Use `pg_dump` and `pg_restore`:

```bash
# Export from RDS
pg_dump -h rds-host -U username -d database > backup.sql

# Import to Railway
psql [railway-connection-string] < backup.sql
```

## Next Steps

- Configure your application to use the Railway database
- Set up automatic deployments from your repository
- Add monitoring and alerting
- Explore Railway's other services (Redis, MongoDB, etc.)
