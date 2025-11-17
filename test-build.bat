@echo off
echo 🔍 Testing Docker Build Process...

REM Clean up any existing containers/images
echo Cleaning up existing containers...
docker-compose down --rmi all --volumes --remove-orphans 2>nul

echo.
echo 📦 Building backend...
cd backend
docker build -t finport-backend .
if %ERRORLEVEL% neq 0 (
    echo ❌ Backend build failed!
    exit /b 1
)
cd ..

echo.
echo 🎨 Building frontend...
cd frontend
docker build -t finport-frontend .
if %ERRORLEVEL% neq 0 (
    echo ❌ Frontend build failed!
    exit /b 1
)
cd ..

echo.
echo ✅ All builds successful!
echo.
echo 🚀 Starting full deployment...
docker-compose up -d

echo.
echo 📊 Checking service status...
timeout /t 5 /nobreak >nul
docker-compose ps

echo.
echo 🎉 Deployment test complete!
echo Frontend: http://localhost:3000
echo Backend: http://localhost:4000
pause