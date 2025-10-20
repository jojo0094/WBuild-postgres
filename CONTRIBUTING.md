# Contributing to WBuild-postgres

Thank you for your interest in contributing to WBuild-postgres!

## Development Setup

1. Clone the repository:
```bash
git clone https://github.com/jojo0094/WBuild-postgres.git
cd WBuild-postgres
```

2. Copy the example environment file:
```bash
cp .env.example .env
```

3. Start the development environment:
```bash
docker-compose up -d
```

## Testing

To test the setup:

```bash
# Run the automated test script
./tests/test_setup.sh

# Or manually test
docker-compose up -d
docker-compose exec postgres psql -U postgres -f /tests/verify_extensions.sql
```

## Making Changes

1. Create a new branch for your changes
2. Make your changes
3. Test your changes thoroughly
4. Submit a pull request

## Updating Extensions

When updating PostgreSQL, PostGIS, or pgRouting versions:

1. Update the base image version in `Dockerfile`
2. Update the pgRouting package version if needed
3. Test the build locally
4. Update the README.md with new version information

## Questions?

Feel free to open an issue if you have any questions or need help.
