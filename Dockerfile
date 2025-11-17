# Multi-stage Dockerfile for Finport (Frontend + Backend)

# Stage 1: Build Frontend
FROM node:18-alpine AS frontend-builder

WORKDIR /app/frontend

# Copy frontend package files
COPY frontend/package*.json ./

# Install frontend dependencies
RUN npm install

# Copy frontend source code
COPY frontend/ ./

# Build the frontend application
RUN npm run build

# Stage 2: Build Backend
FROM node:18-alpine AS backend-builder

WORKDIR /app/backend

# Install necessary packages for Prisma
RUN apk add --no-cache openssl

# Copy backend package files
COPY backend/package*.json ./

# Install backend dependencies
RUN npm install

# Copy prisma schema first
COPY backend/prisma ./prisma/

# Generate Prisma client
RUN npx prisma generate

# Copy backend source code
COPY backend/ ./

# Make sure .env file is included
COPY backend/.env ./

# Stage 3: Production Frontend
FROM node:18-alpine AS frontend-production

WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy built frontend from builder stage
COPY --from=frontend-builder /app/frontend/build ./frontend/build

# Copy redirects file for SPA routing
COPY frontend/_redirects ./frontend/build/_redirects

EXPOSE 3000

CMD ["serve", "-s", "frontend/build", "-l", "3000"]

# Stage 4: Production Backend
FROM node:18-alpine AS backend-production

WORKDIR /app

# Install necessary packages for Prisma
RUN apk add --no-cache openssl

# Copy backend from builder stage
COPY --from=backend-builder /app/backend ./

EXPOSE 5000

CMD ["npm", "start"]
