# Production Deployment Guide

## 🌐 **Current Status**
- ✅ **Backend**: https://finport-unbk.onrender.com (Live)
- ⚠️ **Frontend**: Needs deployment

## 🚀 **Deploy Frontend to Render**

### **Option 1: Render Dashboard**
1. Go to [Render Dashboard](https://render.com/)
2. Click "New +" → "Static Site"
3. Connect your GitHub repo: `AbhishekBaske/finport`
4. Configure:
   - **Name**: `finport-frontend`
   - **Root Directory**: `frontend`
   - **Build Command**: `npm install && npm run build`
   - **Publish Directory**: `build`
   - **Environment Variables**:
     ```
     NODE_ENV=production
     VITE_API_URL=https://finport-unbk.onrender.com
     ```

### **Option 2: Render CLI**
```bash
# Install Render CLI
npm install -g @render/cli

# Deploy from frontend directory
cd frontend
render deploy
```

### **Option 3: Alternative Frontend Script**
Update frontend package.json start script to:
```json
"start": "serve -s build -l $PORT"
```

## 🔧 **Environment Configuration**

### **Backend (Already Configured)**
- Environment: Production
- URL: https://finport-unbk.onrender.com
- Port: Auto-assigned by Render
- CORS: Updated to allow frontend domain

### **Frontend Configuration**
- **API URL**: Automatically detects environment
  - Local: `http://localhost:5000`  
  - Production: `https://finport-unbk.onrender.com`
- **Routing**: SPA redirects configured
- **Build**: Optimized with code splitting

## 📋 **Deployment Checklist**

- ✅ Backend deployed and running
- ✅ Database connected
- ✅ Environment variables set
- ✅ CORS configured for production
- ✅ Frontend build optimized
- ✅ API endpoints updated
- ⬜ Frontend deployed to Render
- ⬜ Custom domain configured (optional)

## 🔗 **Quick Links**

- **Live Backend**: https://finport-unbk.onrender.com
- **Health Check**: https://finport-unbk.onrender.com/health
- **API Base**: https://finport-unbk.onrender.com/api
- **Frontend Repo**: https://github.com/AbhishekBaske/finport

## 🛠️ **Local Development**

```bash
# Backend
cd backend && npm start
# → http://localhost:5000

# Frontend  
cd frontend && npm run dev
# → http://localhost:3000

# Docker
docker compose up --build
```

## 🔍 **Troubleshooting**

### **Frontend Not Loading**
1. Check build logs in Render dashboard
2. Verify environment variables are set
3. Check network tab for API call errors

### **CORS Issues**
1. Backend CORS is configured for production
2. Check if frontend URL is in allowed origins
3. Verify credentials are being sent with requests

### **API Connection Issues**
1. Verify backend is running: https://finport-unbk.onrender.com/health
2. Check frontend API URL configuration
3. Test API endpoints directly