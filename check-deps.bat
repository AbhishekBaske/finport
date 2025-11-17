@echo off
echo 🔍 Checking Package Dependencies...
echo.

echo 📦 Backend Dependencies Status:
cd backend
echo Current directory: %CD%
npm list --depth=0
if %ERRORLEVEL% neq 0 (
    echo.
    echo ⚠️  Missing backend dependencies detected!
    echo 🔄 Installing missing packages...
    npm install
    if %ERRORLEVEL% neq 0 (
        echo ❌ Backend dependency installation failed!
        pause
        exit /b 1
    )
    echo ✅ Backend dependencies installed successfully!
)

echo.
echo 🎨 Frontend Dependencies Status:
cd ..\frontend
echo Current directory: %CD%
npm list --depth=0
if %ERRORLEVEL% neq 0 (
    echo.
    echo ⚠️  Missing frontend dependencies detected!
    echo 🔄 Installing missing packages...
    npm install
    if %ERRORLEVEL% neq 0 (
        echo ❌ Frontend dependency installation failed!
        pause
        exit /b 1
    )
    echo ✅ Frontend dependencies installed successfully!
)

echo.
echo 🎉 All dependencies verified and installed!
echo.
echo 📝 Quick Start Commands:
echo   Backend:  cd backend && npm start
echo   Frontend: cd frontend && npm run dev
echo   Docker:   docker compose up --build
echo.
pause