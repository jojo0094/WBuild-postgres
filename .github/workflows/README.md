# GitHub Actions Workflows

This directory contains automated workflows for the WBuild-postgres project.

## Railway Deployment Workflow

**File:** `railway-deploy.yml`

### Purpose

Automatically deploys the PostgreSQL database to Railway.app when changes are pushed to the main or master branch.

### Triggers

- Push to `main` or `master` branch
- Manual trigger via GitHub Actions UI (workflow_dispatch)

### Required Secrets

Configure these in your GitHub repository settings (Settings > Secrets and variables > Actions):

1. **RAILWAY_TOKEN** (Required)
   - Your Railway API token
   - Get it from: https://railway.app/account/tokens
   - Never commit this to the repository!

2. **RAILWAY_SERVICE_ID** (Optional)
   - Your Railway service ID
   - Only needed if you have multiple services in your Railway project
   - Defaults to 'postgres' if not provided

### Workflow Steps

1. **Checkout code** - Gets the latest code from the repository
2. **Install Railway CLI** - Installs the Railway command-line tool
3. **Deploy to Railway** - Deploys the application using your Railway token
4. **Verify Deployment** - Confirms the deployment was successful

### Usage

#### Automatic Deployment

Simply push to the main or master branch:

```bash
git add .
git commit -m "Update database configuration"
git push origin main
```

#### Manual Deployment

1. Go to the "Actions" tab in your GitHub repository
2. Select "Deploy to Railway" workflow
3. Click "Run workflow"
4. Select the branch to deploy
5. Click "Run workflow"

### Security

- The workflow uses GitHub Secrets to securely store your Railway token
- The token is never exposed in logs or commit history
- Only repository collaborators with appropriate permissions can trigger deployments

### Troubleshooting

#### Deployment fails with "Invalid token"

- Verify your `RAILWAY_TOKEN` secret is set correctly
- Check if the token has expired
- Generate a new token and update the secret

#### Deployment fails with "Service not found"

- Verify your `RAILWAY_SERVICE_ID` secret is correct
- Check if the service exists in your Railway project
- Try deploying without the service ID (it will use the default)

#### Workflow doesn't trigger automatically

- Ensure you're pushing to `main` or `master` branch
- Check if the workflow file is in the correct location
- Verify the workflow is enabled in the Actions tab

### Customization

You can customize the workflow by editing `railway-deploy.yml`:

- Add different branch triggers
- Include build or test steps before deployment
- Add notifications (Slack, email, etc.)
- Include post-deployment verification steps

### Best Practices

1. **Test locally first** - Always test changes locally before pushing
2. **Use pull requests** - Review changes before merging to main
3. **Monitor deployments** - Check the Actions tab after each deployment
4. **Keep secrets secure** - Never share or commit Railway tokens
5. **Rotate tokens regularly** - Update your Railway token every 90 days

### Additional Resources

- [Railway Documentation](https://docs.railway.app)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Railway CLI Documentation](https://docs.railway.app/develop/cli)
