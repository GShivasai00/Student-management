@echo off
echo ========================================
echo  Student Management System Setup
echo ========================================
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not installed or not running.
    echo.
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop
    echo After installation, start Docker Desktop and run this script again.
    echo.
    pause
    exit /b 1
)

echo ✅ Docker is available.
echo.

REM Check if Docker is running
docker ps >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not running.
    echo Please start Docker Desktop and run this script again.
    echo.
    pause
    exit /b 1
)

echo ✅ Docker is running.
echo.

echo Starting MySQL Database...
docker-compose -f docker-compose-mysql.yml up -d

if %errorlevel% neq 0 (
    echo ❌ Failed to start MySQL container.
    echo Please check Docker is running and try again.
    echo.
    pause
    exit /b 1
)

echo ✅ MySQL Database started successfully!
echo.

echo Waiting for database to be ready...
timeout /t 10 /nobreak >nul

echo.
echo ========================================
echo  Database Configuration
echo ========================================
echo Host: localhost
echo Port: 3306
echo Database: student_management
echo Username: studentuser
echo Password: studentpass123
echo.
echo Default Admin Login:
echo Username: admin
echo Password: admin123
echo.

echo ========================================
echo  Application Setup Complete!
echo ========================================
echo.
echo Your Student Management System is now ready to run with a real database!
echo.
echo Next steps:
echo 1. Build and deploy your application to Tomcat
echo 2. Access the application at: http://localhost:8080/student_management_system
echo 3. Login with admin/admin123 or register a new account
echo.
echo To stop the database later, run: stop-mysql.bat
echo.

pause
