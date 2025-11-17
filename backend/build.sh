#!/bin/bash

# Render.com build script for backend
set -e

echo "Starting backend build process..."

# Install dependencies
npm install

# Generate Prisma client
npx prisma generate

# Run database migrations (if needed)
if [ "$NODE_ENV" = "production" ]; then
  echo "Running database migrations..."
  npx prisma migrate deploy
fi

echo "Backend build completed successfully!"