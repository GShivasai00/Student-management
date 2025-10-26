@echo off
echo Starting MySQL Database with Docker...
echo.

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Docker is not installed or not running.
    echo Please install Docker Desktop from: https://www.docker.com/products/docker-desktop
    echo.
    pause
    exit /b 1
)

echo Docker is available. Starting MySQL container...
echo.

REM Start MySQL container
docker-compose -f docker-compose-mysql.yml up -d

if %errorlevel% equ 0 (
    echo.
    echo ✅ MySQL Database started successfully!
    echo.
    echo Database Details:
    echo - Host: localhost
    echo - Port: 3306
    echo - Database: student_management
    echo - Root Password: rootpassword123
    echo - User: studentuser
    echo - User Password: studentpass123
    echo.
    echo The database schema has been automatically created.
    echo You can now run your Student Management System!
    echo.
    echo To stop the database, run: docker-compose -f docker-compose-mysql.yml down
    echo.
) else (
    echo.
    echo ❌ Failed to start MySQL container.
    echo Please check Docker is running and try again.
    echo.
)

pause
