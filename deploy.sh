#!/bin/bash

# Quick deployment script for Render.com
# Run this script to prepare your project for Render deployment

set -e

echo "🚀 Preparing Finport for Render.com deployment..."

# Check if we're in the right directory
if [ ! -f "render.yaml" ]; then
    echo "❌ Error: render.yaml not found. Make sure you're in the project root directory."
    exit 1
fi

echo "📦 Installing dependencies..."

# Install backend dependencies
echo "Installing backend dependencies..."
cd backend
npm install
cd ..

# Install frontend dependencies  
echo "Installing frontend dependencies..."
cd frontend
npm install
cd ..

echo "🔧 Generating Prisma client..."
cd backend
npx prisma generate
cd ..

echo "🏗️ Testing frontend build..."
cd frontend
npm run build
cd ..

echo "✅ Project ready for Render deployment!"
echo ""
echo "Next steps:"
echo "1. Push your code to GitHub"
echo "2. Connect your repository to Render.com"
echo "3. Render will automatically detect and use the render.yaml configuration"
echo ""
echo "📖 For detailed instructions, see RENDER_DEPLOYMENT.md"