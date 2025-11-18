# Multi-stage build for optimized production deployment
FROM node:18-alpine AS base
WORKDIR /app

# Install dependencies
FROM base AS deps
COPY package*.json ./
RUN npm ci && npm cache clean --force

# Build stage
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Set environment variables for production build
ENV NODE_ENV=production
ENV VITE_API_URL=https://finport-backend.up.railway.app

# Build the application
RUN npm run build

# Production stage with nginx for serving static files
FROM nginx:alpine AS production

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built application
COPY --from=builder /app/build /usr/share/nginx/html

# Add non-root user for security
RUN addgroup -g 1001 -S nginx && adduser -S nginx -u 1001

# Expose port 80
EXPOSE 80

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/ || exit 1

# Start nginx
CMD ["nginx", "-g", "daemon off;"]