# Render Deployment Configuration for Frontend

## Build Command:
npm install && npm run build

## Start Command:
serve -s build -l $PORT

## Environment Variables:
NODE_ENV=production
VITE_API_URL=https://finport-unbk.onrender.com

## Static Site Settings:
- Auto-deploy: Yes  
- Build & Deploy: Yes
- Build Directory: build
- Headers: 
  /*
    X-Frame-Options: DENY
    X-XSS-Protection: 1; mode=block
    X-Content-Type-Options: nosniff
    Referrer-Policy: same-origin

## Redirects (for SPA routing):
/*    /index.html   200