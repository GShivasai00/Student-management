@echo off
echo ========================================
echo  Quick Database Setup
echo ========================================
echo.

echo This script will quickly set up your MySQL database
echo for the Student Management System.
echo.

echo Step 1: Create Database and Tables
echo ========================================
echo Please enter your MySQL root password when prompted:
echo.

"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p < setup-database.sql

if %errorlevel% equ 0 (
    echo.
    echo ✅ Database setup completed successfully!
    echo.
    echo Database Details:
    echo - Database: student_management
    echo - Tables: users, students
    echo - Sample data: 1 admin user, 5 students
    echo.
    echo Default Admin Login:
    echo - Username: admin
    echo - Password: admin123
    echo.
    echo Your application is ready to connect to MySQL!
    echo.
) else (
    echo.
    echo ❌ Database setup failed.
    echo.
    echo Common issues:
    echo 1. Wrong MySQL password
    echo 2. MySQL service not running
    echo 3. MySQL not installed
    echo.
    echo Solutions:
    echo 1. Check your MySQL password
    echo 2. Start MySQL service
    echo 3. Install MySQL if needed
    echo.
)

pause
