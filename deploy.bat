@echo off
echo 🚀 Starting Finport Deployment...
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Docker is not installed or not in PATH!
    echo Please install Docker Desktop from: https://docs.docker.com/get-docker/
    echo After installation, restart your computer and try again.
    pause
    exit /b 1
)

REM Check if Docker is running
docker info >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Docker is not running!
    echo Please start Docker Desktop and try again.
    pause
    exit /b 1
)

echo ✅ Docker is ready!
echo.

REM Stop any running containers
echo Stopping existing containers...
docker compose down 2>nul || docker-compose down 2>nul

REM Build and start the services
echo Building and starting services...
docker compose up --build -d 2>nul || docker-compose up --build -d

if %ERRORLEVEL% neq 0 (
    echo ❌ Deployment failed! Check the error messages above.
    pause
    exit /b 1
)

REM Wait for services to start
echo Waiting for services to start...
timeout /t 10 /nobreak > nul

REM Check service health
echo Checking service status...
docker compose ps 2>nul || docker-compose ps

echo.
echo 🎉 Deployment complete!
echo.
echo Services are now running:
echo 📊 Frontend (Vite): http://localhost:3000
echo 🔧 Backend API: http://localhost:4000
echo 🗄️ PostgreSQL: localhost:5432
echo 📦 Redis: localhost:6379
echo.
echo To stop all services: docker compose down
echo To view logs: docker compose logs -f
echo.
echo Press any key to open the application in your browser...
pause >nul
start http://localhost:3000