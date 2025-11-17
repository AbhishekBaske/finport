@echo off
echo 🚀 Starting Finport Local Development...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ❌ Node.js is not installed!
    echo Please install Node.js from: https://nodejs.org/
    pause
    exit /b 1
)

echo ✅ Node.js is ready!
echo.

echo 📦 Installing backend dependencies...
cd backend
call npm install
if %ERRORLEVEL% neq 0 (
    echo ❌ Backend dependency installation failed!
    pause
    exit /b 1
)

echo.
echo 🎨 Installing frontend dependencies...
cd ..\frontend
call npm install
if %ERRORLEVEL% neq 0 (
    echo ❌ Frontend dependency installation failed!
    pause
    exit /b 1
)

echo.
echo 🎉 Setup complete!
echo.
echo To start development:
echo 1. Set up your PostgreSQL database
echo 2. Create backend\.env file with DATABASE_URL
echo 3. Run: cd backend && npm start
echo 4. In another terminal: cd frontend && npm run dev
echo.
echo Frontend will be available at: http://localhost:3000
echo Backend API will be available at: http://localhost:4000
echo.
pause