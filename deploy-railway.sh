#!/bin/bash

# Railway deployment preparation script
set -e

echo "🚂 Preparing Finport for Railway deployment..."

# Check if we're in the right directory
if [ ! -f "railway.json" ]; then
    echo "❌ Error: railway.json not found. Make sure you're in the project root directory."
    exit 1
fi

echo "📦 Installing Railway CLI..."
if ! command -v railway &> /dev/null; then
    echo "Installing Railway CLI..."
    npm install -g @railway/cli
else
    echo "Railway CLI already installed"
fi

echo "🔐 Please login to Railway..."
railway login

echo "📦 Installing dependencies..."

# Install backend dependencies
echo "Installing backend dependencies..."
cd backend
npm install
npx prisma generate
cd ..

# Install frontend dependencies  
echo "Installing frontend dependencies..."
cd frontend
npm install
npm run build
cd ..

echo "🚂 Creating Railway project..."
railway project new finport

echo "🗄️ Adding PostgreSQL database..."
railway add postgresql

echo "⚙️ Setting up services..."

# Deploy backend
echo "Deploying backend service..."
cd backend
railway up --service backend
cd ..

# Deploy frontend
echo "Deploying frontend service..."
cd frontend
railway up --service frontend
cd ..

echo "✅ Railway deployment setup complete!"
echo ""
echo "Next steps:"
echo "1. Set environment variables in Railway dashboard"
echo "2. Configure custom domains (optional)"
echo "3. Monitor deployment in Railway dashboard"
echo ""
echo "🌐 Railway Dashboard: https://railway.app/dashboard"
echo "📖 For detailed instructions, see RAILWAY_DEPLOYMENT.md"