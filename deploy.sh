#!/bin/bash

echo "🚀 Starting Finport Deployment..."
echo

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed!"
    echo "Please install Docker from: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker is running
if ! docker info &> /dev/null; then
    echo "❌ Docker is not running!"
    echo "Please start Docker and try again."
    exit 1
fi

echo "✅ Docker is ready!"
echo

# Stop any running containers
echo "Stopping existing containers..."
docker compose down 2>/dev/null || docker-compose down 2>/dev/null

# Build and start the services
echo "Building and starting services..."
if docker compose up --build -d 2>/dev/null; then
    echo "✅ Using docker compose"
elif docker-compose up --build -d 2>/dev/null; then
    echo "✅ Using docker-compose"
else
    echo "❌ Deployment failed! Check the error messages above."
    exit 1
fi

# Wait for services to start
echo "Waiting for services to start..."
sleep 10

# Check service health
echo "Checking service status..."
docker compose ps 2>/dev/null || docker-compose ps

echo
echo "🎉 Deployment complete!"
echo
echo "Services are now running:"
echo "📊 Frontend (Vite): http://localhost:3000"
echo "🔧 Backend API: http://localhost:4000"
echo "🗄️ PostgreSQL: localhost:5432"
echo "📦 Redis: localhost:6379"
echo
echo "To stop all services: docker compose down"
echo "To view logs: docker compose logs -f"
echo
echo "Opening application in browser..."

# Try to open browser (works on most Linux distros and macOS)
if command -v xdg-open &> /dev/null; then
    xdg-open http://localhost:3000
elif command -v open &> /dev/null; then
    open http://localhost:3000
else
    echo "Please open http://localhost:3000 in your browser"
fi