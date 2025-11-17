# Multi-stage Dockerfile with dotenvx for both frontend and backend
FROM node:20 AS frontend-build
WORKDIR /app/frontend

# Install dotenvx
RUN curl -sfS https://dotenvx.sh/install.sh | sh

COPY frontend/package*.json ./
RUN npm install
COPY frontend ./
RUN dotenvx run -- npm run build

# Backend stage
FROM node:20
WORKDIR /app

# Install dotenvx
RUN curl -sfS https://dotenvx.sh/install.sh | sh

# Copy backend files
COPY backend/package*.json ./
RUN npm install
COPY backend ./

# Copy frontend build
COPY --from=frontend-build /app/frontend/dist ./public

# Install serve for static files
RUN npm install -g serve

EXPOSE 3000

# Start both backend and frontend with dotenvx
CMD ["sh", "-c", "dotenvx run -- node index.js & serve -s public -l 4000"]