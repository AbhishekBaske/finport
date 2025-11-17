# Finport Deployment on Railway

This guide explains how to deploy the Finport application on Railway.

## Prerequisites

- Railway account (railway.app)
- GitHub repository with your code
- Railway CLI (optional but recommended)

## Quick Setup

### 1. Install Railway CLI (Optional)
```bash
npm install -g @railway/cli
railway login
```

### 2. Deploy from GitHub

1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Connect your Finport repository
5. Railway will automatically detect and deploy both services

### 3. Manual Configuration

If automatic detection doesn't work, configure manually:

#### Backend Service
- **Root Directory**: `/backend`
- **Build Command**: `npm install && npx prisma generate && npx prisma migrate deploy`
- **Start Command**: `npm start`
- **Port**: `$PORT` (automatically provided by Railway)

#### Frontend Service
- **Root Directory**: `/frontend` 
- **Build Command**: `npm install && npm run build`
- **Start Command**: `npm run railway:start`
- **Port**: `$PORT`

#### Database Service
- Add PostgreSQL plugin from Railway marketplace
- Note the connection string for backend environment variables

## Environment Variables

### Backend Service Variables

Set these in Railway dashboard > Backend Service > Variables:

```env
NODE_ENV=production
PORT=${{RAILWAY_PORT}}
DATABASE_URL=${{Postgres.DATABASE_URL}}
JWT_SECRET=your-super-secure-jwt-secret
CORS_ORIGIN=${{frontend.RAILWAY_PUBLIC_DOMAIN}}
FINNHUB_API_KEY=your-finnhub-api-key

# Email configuration (optional)
EMAIL=your-email@gmail.com
EMAIL_PASSWORD=your-app-password
```

### Frontend Service Variables

```env
NODE_ENV=production
PORT=${{RAILWAY_PORT}}
VITE_API_URL=${{backend.RAILWAY_PUBLIC_DOMAIN}}
```

## Automatic Deployment

Railway automatically deploys when you push to your main branch. The configuration files ensure:

- ✅ Dependencies are installed
- ✅ Database migrations run automatically
- ✅ Services start with correct ports
- ✅ CORS is configured properly

## Custom Domains

1. Go to service settings in Railway
2. Add custom domain under "Networking"
3. Update your DNS records as instructed
4. SSL certificates are automatically provisioned

## Railway CLI Commands

```bash
# Deploy current directory
railway up

# View logs
railway logs

# Open service in browser
railway open

# Add environment variables
railway variables set KEY=value

# Connect to database
railway connect postgres
```

## Database Management

### Run Migrations
```bash
# Using Railway CLI
railway shell
npx prisma migrate deploy

# Or set as build command in Railway dashboard
```

### Access Database
```bash
# Connect via Railway CLI
railway connect postgres

# Or use the connection string from environment variables
```

## Monitoring

- **Logs**: View in Railway dashboard or via CLI
- **Metrics**: CPU, memory, and network usage in dashboard
- **Alerts**: Set up in Railway dashboard notifications

## Cost Optimization

### Starter Plan (Free Tier)
- $5 worth of usage included monthly
- Good for development and small projects

### Pro Plan
- $20/month per workspace
- Unlimited usage within workspace
- Priority support

### Usage Tips
- Use Railway's sleep mode for non-production services
- Monitor usage in dashboard
- Optimize build times to reduce costs

## Troubleshooting

### Common Issues

1. **Build Failures**
   ```bash
   # Check logs
   railway logs --tail
   
   # Rebuild
   railway up --detach
   ```

2. **Database Connection Issues**
   - Verify DATABASE_URL is set correctly
   - Check if migrations ran successfully
   - Ensure database service is running

3. **Port Issues**
   - Always use `$PORT` or `process.env.PORT`
   - Don't hardcode port numbers
   - Bind to `0.0.0.0` for host

4. **CORS Issues**
   - Update CORS_ORIGIN with frontend domain
   - Check environment variable references

### Debugging Commands

```bash
# View all services
railway status

# Check environment variables
railway variables

# Shell into service
railway shell

# View service info
railway info
```

## Scaling

Railway automatically scales based on traffic:
- **CPU**: Scales up during high load
- **Memory**: Allocated as needed
- **Instances**: Multiple instances for high availability

## Security

Railway provides:
- ✅ TLS/SSL certificates
- ✅ Private networking between services
- ✅ Secure environment variables
- ✅ Regular security updates

## Migration from Other Platforms

### From Heroku
```bash
# Export Heroku config
heroku config -a your-app-name

# Import to Railway
railway variables set KEY=value
```

### From Vercel/Netlify
- Frontend deployment remains similar
- Backend needs full service setup
- Database migration required

## Support

- [Railway Documentation](https://docs.railway.app)
- [Railway Discord Community](https://discord.gg/railway)
- [GitHub Issues](https://github.com/railwayapp/railway/issues)

---

**Total Cost Estimate**: $0-20/month depending on usage and plan
**Deployment Time**: 5-10 minutes
**Complexity**: ⭐⭐⭐ (Medium)