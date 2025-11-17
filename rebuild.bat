@echo off
echo 🔄 Rebuilding backend container with all dependencies...

echo Stopping existing containers...
docker compose down 2>nul

echo 📦 Building backend with updated dependencies...
docker build --target backend-production -t finport-backend .

if %ERRORLEVEL% neq 0 (
    echo ❌ Backend build failed!
    pause
    exit /b 1
)

echo ✅ Backend build successful!

echo 🎨 Building frontend...
docker build --target frontend-production -t finport-frontend .

if %ERRORLEVEL% neq 0 (
    echo ❌ Frontend build failed!
    pause
    exit /b 1
)

echo ✅ Frontend build successful!

echo 🚀 Starting all services...
docker compose up -d

echo ⏱️  Waiting for services to start...
timeout /t 15 /nobreak >nul

echo 📊 Checking service status...
docker compose ps

echo.
echo 🏥 Testing health endpoints...
curl -s http://localhost:5000/health 2>nul
if %ERRORLEVEL% equ 0 (
    echo ✅ Backend health check passed
) else (
    echo ⚠️  Backend health check failed - service may still be starting
)

echo.
echo 🎉 Rebuild complete! 
echo 📊 Frontend: http://localhost:3000
echo 🔧 Backend: http://localhost:5000  
echo 🏥 Health: http://localhost:5000/health
echo 🌐 Production Backend: https://finport-unbk.onrender.com
echo.
echo 📝 To check logs:
echo    docker compose logs backend
echo    docker compose logs frontend
echo.
echo 🚀 For Render deployment:
echo    Frontend: npm run build && serve -s build
echo    Backend: Already deployed at https://finport-unbk.onrender.com
pause