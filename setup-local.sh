#!/bin/bash

echo "🚀 Starting Finport Local Development..."
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "Please install Node.js from: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js is ready!"
echo

echo "📦 Installing backend dependencies..."
cd backend
npm install
if [ $? -ne 0 ]; then
    echo "❌ Backend dependency installation failed!"
    exit 1
fi

echo
echo "🎨 Installing frontend dependencies..."
cd ../frontend
npm install
if [ $? -ne 0 ]; then
    echo "❌ Frontend dependency installation failed!"
    exit 1
fi

echo
echo "🎉 Setup complete!"
echo
echo "To start development:"
echo "1. Set up your PostgreSQL database"
echo "2. Create backend/.env file with DATABASE_URL"
echo "3. Run: cd backend && npm start"
echo "4. In another terminal: cd frontend && npm run dev"
echo
echo "Frontend will be available at: http://localhost:3000"
echo "Backend API will be available at: http://localhost:4000"
echo