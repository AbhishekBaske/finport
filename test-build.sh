#!/bin/bash

echo "🔍 Testing Docker Build Process..."

# Clean up any existing containers/images
echo "Cleaning up existing containers..."
docker-compose down --rmi all --volumes --remove-orphans 2>/dev/null || true

echo ""
echo "📦 Building backend..."
cd backend && docker build -t finport-backend . && cd ..
if [ $? -ne 0 ]; then
    echo "❌ Backend build failed!"
    exit 1
fi

echo ""
echo "🎨 Building frontend..."
cd frontend && docker build -t finport-frontend . && cd ..
if [ $? -ne 0 ]; then
    echo "❌ Frontend build failed!"
    exit 1
fi

echo ""
echo "✅ All builds successful!"
echo ""
echo "🚀 Starting full deployment..."
docker-compose up -d

echo ""
echo "📊 Checking service status..."
sleep 5
docker-compose ps

echo ""
echo "🎉 Deployment test complete!"
echo "Frontend: http://localhost:3000"
echo "Backend: http://localhost:4000"