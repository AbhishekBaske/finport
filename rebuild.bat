@echo off
echo 🔄 Rebuilding backend container with finnhub dependency...

echo Stopping existing containers...
docker compose down

echo Building backend with new dependencies...
docker build --target backend-production -t finport-backend .

if %ERRORLEVEL% neq 0 (
    echo ❌ Backend build failed!
    pause
    exit /b 1
)

echo ✅ Backend build successful!
echo Starting services...
docker compose up -d

echo Waiting for services to start...
timeout /t 10 /nobreak >nul

echo 📊 Checking service status...
docker compose ps

echo.
echo 🎉 Rebuild complete! 
echo Backend: http://localhost:4000
echo Frontend: http://localhost:3000
echo.
echo To check backend logs: docker compose logs backend
pause