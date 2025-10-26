@echo off
echo ========================================
echo  MySQL Database Setup
echo ========================================
echo.

echo This script will create the student_management database
echo and import the required tables and sample data.
echo.

echo Please enter your MySQL root password when prompted.
echo.

REM Run the SQL script
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p < setup-database.sql

if %errorlevel% equ 0 (
    echo.
    echo ✅ Database setup completed successfully!
    echo.
    echo Database Details:
    echo - Database: student_management
    echo - Default Admin: admin/admin123
    echo - Sample students: 5 students added
    echo.
    echo Your application is now ready to connect to MySQL!
    echo.
) else (
    echo.
    echo ❌ Database setup failed.
    echo Please check your MySQL password and try again.
    echo.
)

pause
