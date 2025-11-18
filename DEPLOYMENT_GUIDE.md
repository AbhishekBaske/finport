# 🚀 Deployment Guide for Finport

## Backend Deployment on Railway

### Prerequisites
1. Railway account (https://railway.app)
2. GitHub repository connected to Railway
3. Environment variables configured

### Steps:

#### 1. **Connect to Railway**
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login to Railway
railway login

# Initialize project
railway init
```

#### 2. **Environment Variables Setup**
Configure these in Railway dashboard:
```env
NODE_ENV=production
DATABASE_URL=your_postgresql_connection_string
JWT_SECRET=your_jwt_secret_key
JWT_EXPIRES_IN=24h
EMAIL=your_smtp_email
EMAIL_PASSWORD=your_smtp_password
FINNHUB_API_KEY=your_finnhub_api_key
ALPHA_VANTAGE_API_KEY=your_alpha_vantage_key
ALLOWED_ORIGINS=https://your-frontend-domain.vercel.app
```

#### 3. **Deploy**
```bash
# Deploy to Railway
railway up
```

#### 4. **Database Migration**
```bash
# Run Prisma migrations on Railway
railway run npx prisma migrate deploy
railway run npx prisma generate
```

---

## Frontend Deployment on Vercel

### Prerequisites
1. Vercel account (https://vercel.com)
2. GitHub repository connected to Vercel

### Steps:

#### 1. **Connect to Vercel**
- Go to https://vercel.com/dashboard
- Click "New Project"
- Import your GitHub repository
- Select the `frontend` folder as the root directory

#### 2. **Environment Variables**
Configure in Vercel dashboard:
```env
VITE_API_URL=https://your-railway-backend-url.up.railway.app
NODE_ENV=production
```

#### 3. **Build Settings**
Vercel will automatically detect:
- **Build Command**: `npm run vercel-build`
- **Output Directory**: `build`
- **Root Directory**: `frontend`

#### 4. **Deploy**
- Click "Deploy"
- Vercel will automatically build and deploy your frontend

---

## 🔧 Configuration Files Created

### Backend (Railway):
- ✅ `Dockerfile` - Multi-stage production build
- ✅ `railway.toml` - Railway-specific configuration
- ✅ `.dockerignore` - Optimized Docker builds
- ✅ Health check endpoint at `/health`

### Frontend (Vercel):
- ✅ `vercel.json` - Vercel deployment configuration
- ✅ `nginx.conf` - Production nginx setup (for Docker)
- ✅ `.dockerignore` - Optimized builds
- ✅ API proxy routing to Railway backend

---

## 🌐 Post-Deployment Steps

### 1. **Update CORS Configuration**
Once deployed, update backend CORS origins:
```javascript
const corsOptions = {
  origin: [
    'https://your-frontend-domain.vercel.app',
    'http://localhost:3000' // Keep for development
  ],
  credentials: true
};
```

### 2. **Update Frontend API URLs**
Update AuthContext and other API calls to use production URLs:
```typescript
const getApiUrl = () => {
  return process.env.NODE_ENV === 'production' 
    ? 'https://your-railway-backend.up.railway.app'
    : 'http://localhost:4000';
};
```

### 3. **SSL/HTTPS Setup**
- Railway: Automatically provides HTTPS
- Vercel: Automatically provides HTTPS

### 4. **Custom Domains (Optional)**
- Railway: Add custom domain in dashboard
- Vercel: Add custom domain in project settings

---

## 🐳 Docker Commands for Local Testing

### Backend:
```bash
cd backend
docker build -t finport-backend .
docker run -p 4000:4000 --env-file .env finport-backend
```

### Frontend:
```bash
cd frontend
docker build -t finport-frontend .
docker run -p 80:80 finport-frontend
```

---

## 📊 Monitoring & Logs

### Railway:
- View logs: `railway logs`
- Monitor metrics in Railway dashboard
- Health checks at `/health` endpoint

### Vercel:
- View deployment logs in Vercel dashboard
- Monitor function executions
- Real-time error tracking

---

## 🔒 Security Features

### Backend:
- Non-root user in Docker container
- Health checks for automatic restarts
- Environment variable isolation
- CORS protection

### Frontend:
- Security headers (CSP, XSS protection)
- Static file caching
- Gzip compression
- HTTPS enforcement

---

## 🚨 Troubleshooting

### Common Issues:

1. **CORS Errors**: Update ALLOWED_ORIGINS in Railway
2. **Database Connection**: Verify DATABASE_URL in Railway
3. **Build Failures**: Check node_modules and package-lock.json
4. **API Routes**: Verify proxy configuration in vercel.json

### Support:
- Railway Docs: https://docs.railway.app
- Vercel Docs: https://vercel.com/docs

---

**✅ Your Finport application is now ready for production deployment!**