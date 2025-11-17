#!/bin/bash

echo "🚀 Starting Finport Deployment..."

# Stop any running containers
echo "Stopping existing containers..."
docker-compose down

# Remove old images (optional - uncomment if you want to rebuild everything)
# docker-compose down --rmi all

# Build and start the services
echo "Building and starting services..."
docker-compose up --build -d

# Wait for services to start
echo "Waiting for services to start..."
sleep 10

# Check service health
echo "Checking service status..."
docker-compose ps

echo ""
echo "🎉 Deployment complete!"
echo ""
echo "Services are now running:"
echo "📊 Frontend (Vite): http://localhost:3000"
echo "🔧 Backend API: http://localhost:4000"
echo "🗄️ PostgreSQL: localhost:5432"
echo "📦 Redis: localhost:6379"
echo ""
echo "To stop all services: docker-compose down"
echo "To view logs: docker-compose logs -f"