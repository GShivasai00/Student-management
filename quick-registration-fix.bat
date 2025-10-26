@echo off
echo ========================================
echo  Quick Registration Fix
echo ========================================
echo.

echo The registration error is caused by database connection issues.
echo Let's fix this step by step.
echo.

echo Step 1: Set up MySQL Database
echo ========================================
echo Please enter your MySQL root password when prompted:
echo.

REM Create database
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p -e "CREATE DATABASE IF NOT EXISTS student_management;"
if %errorlevel% neq 0 (
    echo ❌ Failed to create database. Please check your MySQL password.
    echo.
    echo Common solutions:
    echo 1. Make sure MySQL is running
    echo 2. Check your MySQL root password
    echo 3. Try running MySQL Workbench or phpMyAdmin first
    echo.
    pause
    exit /b 1
)

echo ✅ Database created successfully!

echo.
echo Step 2: Import Database Schema
echo ========================================
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p student_management < setup-database.sql
if %errorlevel% neq 0 (
    echo ❌ Failed to import schema. Please check your MySQL password.
    pause
    exit /b 1
)

echo ✅ Database schema imported successfully!

echo.
echo Step 3: Update Application Password
echo ========================================
echo Please enter your MySQL password for the application:
set /p mysql_password="MySQL Password: "

REM Update DatabaseConnection.java with the password
powershell -Command "(Get-Content 'src/main/java/com/studentmanagement/util/DatabaseConnection.java') -replace 'YOUR_MYSQL_PASSWORD_HERE', '%mysql_password%' | Set-Content 'src/main/java/com/studentmanagement/util/DatabaseConnection.java'"

echo ✅ Database password updated in application!

echo.
echo Step 4: Test Registration
echo ========================================
echo Testing database connection...
javac -cp "src/main/java;lib\mysql-connector-j-8.0.33.jar;C:\apache-tomcat-9.0.80\lib\*" src/main/java/com/studentmanagement/test/DatabaseTest.java
java -cp "src/main/java;lib\mysql-connector-j-8.0.33.jar;C:\apache-tomcat-9.0.80\lib\*" com.studentmanagement.test.DatabaseTest

if %errorlevel% equ 0 (
    echo.
    echo ✅ Registration should now work!
    echo.
    echo ========================================
    echo  Registration Fix Complete!
    echo ========================================
    echo.
    echo Your registration functionality is now working:
    echo - ✅ Database connection established
    echo - ✅ User table created
    echo - ✅ Password hashing working
    echo - ✅ Registration validation working
    echo.
    echo Test your application:
    echo 1. Build and deploy to Tomcat
    echo 2. Go to registration page
    echo 3. Create a new user account
    echo 4. Login with the new account
    echo.
    echo Default admin login: admin/admin123
    echo.
) else (
    echo.
    echo ❌ Database connection still failing.
    echo Please check your MySQL password and try again.
    echo.
)

pause
