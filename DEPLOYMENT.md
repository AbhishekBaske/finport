# Finport - Deployment Guide

This project includes multiple deployment options for the full-stack Finport application.

## Prerequisites

### Option 1: Docker Deployment (Recommended)
- **Install Docker Desktop**: Download from [docker.com](https://docs.docker.com/get-docker/)
- **Install Docker Compose**: Usually included with Docker Desktop
- Ports 3000, 4000, 5432, and 6379 available

### Option 2: Local Development
- Node.js 18+ installed
- PostgreSQL database running
- Redis server running (optional)

## Docker Installation

### Windows:
1. Download Docker Desktop from [docker.com](https://docs.docker.com/desktop/install/windows-install/)
2. Install and restart your computer
3. Verify installation: `docker --version` and `docker compose version`

### Linux:
```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Deployment Options

### 🐳 Docker Deployment (Production-Ready)

**Quick Start:**
```bash
# Windows
test-build.bat

# Linux/Mac
chmod +x test-build.sh && ./test-build.sh
```

**Manual Steps:**
```bash
# Build and start all services
docker compose up --build -d

# Or use the older docker-compose syntax
docker-compose up --build -d
```

### 💻 Local Development

**Backend:**
```bash
cd backend
npm install
# Set up your PostgreSQL database
# Update DATABASE_URL in .env file
npx prisma generate
npx prisma migrate dev
npm start
```

**Frontend:**
```bash
cd frontend
npm install
npm run dev
```

## Services

After deployment, the following services will be available:

- **Frontend (React + Vite)**: http://localhost:3000
- **Backend (Node.js + Express)**: http://localhost:4000
- **Database (PostgreSQL)**: localhost:5432
- **Cache (Redis)**: localhost:6379

## Environment Variables

The Docker Compose file includes default environment variables. For production, update:

- `JWT_SECRET`: Change to a secure secret key
- Database credentials in the `db` service
- API URLs in frontend environment

## Development vs Production

### Development
```bash
cd frontend && npm run dev
cd backend && npm start
```

### Production (Docker)
```bash
docker-compose up --build -d
```

## Useful Commands

```bash
# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and restart
docker-compose up --build -d

# View running containers
docker-compose ps

# Shell into frontend container
docker-compose exec frontend sh

# Shell into backend container
docker-compose exec backend sh
```

## Troubleshooting

1. **Port conflicts**: Ensure ports 3000, 4000, 5432, 6379 are free
2. **Build issues**: Try `docker-compose down --rmi all` then rebuild
3. **Database connection**: Check if PostgreSQL container is running
4. **Frontend not loading**: Verify Vite build completed successfully

## Architecture

```
┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │    Backend      │
│   (React+Vite)  │───▶│   (Node.js)     │
│   Port: 3000    │    │   Port: 4000    │
└─────────────────┘    └─────────────────┘
                              │
                              ▼
                       ┌─────────────────┐
                       │   PostgreSQL    │
                       │   Port: 5432    │
                       └─────────────────┘
                              │
                       ┌─────────────────┐
                       │     Redis       │
                       │   Port: 6379    │
                       └─────────────────┘
```