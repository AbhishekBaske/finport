# Finport Deployment on Render.com

This guide explains how to deploy the Finport application on Render.com.

## Prerequisites

- Render.com account
- GitHub repository with your code
- Environment variables configured

## Deployment Options

### Option 1: Infrastructure as Code (Recommended)

1. **Push your code to GitHub**
2. **Connect your repository to Render**
3. **Use the `render.yaml` file** for automatic deployment

The `render.yaml` file in the root directory defines:
- Backend API service (Node.js)
- Frontend static site (React/Vite)
- PostgreSQL database

### Option 2: Manual Setup

#### Backend Deployment

1. Create a new **Web Service** in Render
2. Connect your GitHub repository
3. Configure:
   - **Build Command**: `cd backend && npm install && npx prisma generate && npx prisma migrate deploy`
   - **Start Command**: `cd backend && npm start`
   - **Environment**: Node
   - **Region**: Ohio (or your preferred region)

#### Frontend Deployment

1. Create a new **Static Site** in Render
2. Connect the same repository
3. Configure:
   - **Build Command**: `cd frontend && npm install && npm run build`
   - **Publish Directory**: `frontend/dist`

#### Database Setup

1. Create a **PostgreSQL** database in Render
2. Note the connection string
3. Add it to backend environment variables

## Environment Variables

### Backend Environment Variables

Set these in your backend service:

```env
NODE_ENV=production
PORT=4000
DATABASE_URL=<your-postgres-connection-string>
JWT_SECRET=<generate-a-secure-secret>
CORS_ORIGIN=https://your-frontend-url.onrender.com
```

### Frontend Environment Variables (if needed)

```env
VITE_API_URL=https://your-backend-url.onrender.com
```

## Database Migration

The deployment automatically runs:
- `npx prisma generate` - Generate Prisma client
- `npx prisma migrate deploy` - Apply database migrations

## Custom Domains

1. Go to your service settings
2. Add custom domain
3. Configure DNS settings with your domain provider

## Health Checks

- Backend includes health check endpoint at `/`
- Frontend uses SPA routing with fallback to `index.html`

## Security Headers

The deployment includes security headers:
- `X-Frame-Options: DENY`
- `X-Content-Type-Options: nosniff`

## Monitoring

- View logs in Render dashboard
- Set up alerts for service failures
- Monitor database performance

## Troubleshooting

### Common Issues

1. **Build Failures**
   - Check build logs in Render dashboard
   - Verify all dependencies are in package.json
   - Ensure build scripts are correct

2. **Database Connection Issues**
   - Verify DATABASE_URL environment variable
   - Check database is running
   - Ensure migrations have been applied

3. **Frontend Routing Issues**
   - Verify SPA routing is configured
   - Check that all routes redirect to index.html

### Useful Commands

```bash
# Check backend logs
render logs <backend-service-id>

# Check frontend logs  
render logs <frontend-service-id>

# Manual database migration
render shell <backend-service-id>
npx prisma migrate deploy
```

## Scaling

- **Starter Plan**: Good for development/testing
- **Standard Plan**: For production with more resources
- **Pro Plan**: For high-traffic applications

## Cost Estimation

- **Backend (Web Service)**: $7/month (Starter)
- **Frontend (Static Site)**: Free tier available
- **Database (PostgreSQL)**: $7/month (Starter)

**Total**: ~$14/month for starter setup

## Additional Features

- **Auto-deploy**: Enabled by default on main branch
- **Preview deploys**: Available for pull requests
- **SSL certificates**: Automatically provisioned
- **CDN**: Built-in for static sites