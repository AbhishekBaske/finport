#!/bin/bash

# Render.com build script for frontend
set -e

echo "Starting frontend build process..."

# Install dependencies
npm install

# Build the React app
npm run build

echo "Frontend build completed successfully!"
echo "Built files are in dist/ directory"