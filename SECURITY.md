# Security Guidelines

This document outlines security best practices for deploying and managing WBuild-postgres.

## Railway API Token Security

### Getting Your Token

1. Visit [Railway Account Tokens](https://railway.app/account/tokens)
2. Create a new token with a descriptive name
3. Copy the token immediately (it won't be shown again)
4. Store it securely

### Storing Tokens Safely

**DO:**
- ✅ Store tokens in GitHub Secrets for CI/CD
- ✅ Use environment variables for local development
- ✅ Keep tokens in password managers
- ✅ Rotate tokens regularly (every 90 days recommended)
- ✅ Use separate tokens for different environments
- ✅ Delete tokens when no longer needed

**DON'T:**
- ❌ Commit tokens to version control
- ❌ Share tokens via email or chat
- ❌ Hardcode tokens in scripts or code
- ❌ Use the same token across multiple projects
- ❌ Store tokens in plain text files

### GitHub Secrets Setup

1. Navigate to your repository on GitHub
2. Go to Settings > Secrets and variables > Actions
3. Click "New repository secret"
4. Add these secrets:
   - `RAILWAY_TOKEN`: Your Railway API token
   - `RAILWAY_SERVICE_ID`: (Optional) Your Railway service ID

### Rotating Tokens

If a token is compromised:

1. Immediately revoke it in Railway
2. Generate a new token
3. Update GitHub Secrets
4. Update any local `.env` files
5. Notify your team

## Database Security

### Password Best Practices

- Use strong, unique passwords (minimum 16 characters)
- Include uppercase, lowercase, numbers, and special characters
- Never use default passwords in production
- Rotate database passwords regularly

### Railway Environment Variables

Configure these in Railway dashboard (not in code):

```
POSTGRES_PASSWORD=<strong-password>
POSTGRES_USER=<username>
POSTGRES_DB=<database-name>
```

### Network Security

- Use Railway's built-in network isolation
- Limit database access to trusted IP addresses
- Use SSL/TLS for all connections
- Enable Railway's private networking when possible

### Connection String Security

**Never expose connection strings in:**
- Public repositories
- Client-side code
- Log files
- Error messages

Always use environment variables for connection details.

## Monitoring and Auditing

### Railway Monitoring

Monitor your deployment:
- Check deployment logs regularly
- Set up alerts for unusual activity
- Review access logs
- Track API usage

### GitHub Actions Logs

- Review workflow run logs
- Ensure no secrets appear in logs
- Set up notifications for failed deployments
- Use `::add-mask::` for sensitive output

## Incident Response

If you suspect a security breach:

1. **Immediately:**
   - Revoke compromised tokens
   - Change database passwords
   - Review access logs

2. **Investigate:**
   - Check Railway deployment history
   - Review GitHub Actions logs
   - Identify the scope of the breach

3. **Recover:**
   - Generate new credentials
   - Update all affected systems
   - Document the incident

4. **Prevent:**
   - Implement additional security measures
   - Update team training
   - Review and improve processes

## Compliance and Best Practices

### Data Protection

- Follow GDPR/CCPA requirements if applicable
- Implement data encryption at rest
- Use encrypted connections (SSL/TLS)
- Regular backups with encryption

### Access Control

- Implement least privilege principle
- Use separate accounts for different purposes
- Enable multi-factor authentication (MFA)
- Regular access audits

### Code Security

- Keep dependencies updated
- Scan for vulnerabilities regularly
- Use Dependabot or similar tools
- Review code changes carefully

## Reporting Security Issues

If you discover a security vulnerability:

1. **Do not** open a public issue
2. Email the repository maintainer directly
3. Provide detailed information about the vulnerability
4. Allow time for the issue to be addressed before disclosure

## Resources

- [Railway Security Documentation](https://docs.railway.app/reference/security)
- [GitHub Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [PostgreSQL Security Guide](https://www.postgresql.org/docs/current/security.html)
- [OWASP Database Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Database_Security_Cheat_Sheet.html)

## Updates

This security guide is reviewed and updated regularly. Last update: 2025-10-20
