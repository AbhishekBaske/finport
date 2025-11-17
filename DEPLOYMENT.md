# Finport - Docker Deployment Guide

This project includes Docker configurations for easy deployment of the full-stack Finport application.

## Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Ports 3000, 4000, 5432, and 6379 available

### Deployment

**Windows:**
```bash
deploy.bat
```

**Linux/Mac:**
```bash
chmod +x deploy.sh
./deploy.sh
```

**Manual Docker Compose:**
```bash
docker-compose up --build -d
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