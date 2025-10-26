@echo off
echo ========================================
echo Database Setup for Student Management System
echo ========================================
echo.
echo This script will help you set up the MySQL database.
echo.
echo Prerequisites:
echo 1. MySQL Server must be installed and running
echo 2. You need MySQL root password
echo.
echo ========================================
echo DATABASE SETUP STEPS:
echo ========================================
echo.
echo 1. Open MySQL Command Line Client or MySQL Workbench
echo.
echo 2. Run these commands:
echo    CREATE DATABASE student_management;
echo    USE student_management;
echo    SOURCE database/schema.sql;
echo.
echo 3. Or run this command from command line:
echo    mysql -u root -p student_management ^< database/schema.sql
echo.
echo ========================================
echo ALTERNATIVE: Manual Setup
echo ========================================
echo.
echo 1. Open MySQL Workbench or phpMyAdmin
echo 2. Create new database: student_management
echo 3. Open database/schema.sql file
echo 4. Copy and paste the SQL commands
echo 5. Execute the script
echo.
echo ========================================
echo TEST CONNECTION:
echo ========================================
echo.
echo After setting up the database, test the connection:
echo 1. Open: http://localhost:8080/student-management-system/
echo 2. Try to login with: admin / admin123
echo 3. If you get database errors, check your MySQL password in:
echo    src/main/java/com/studentmanagement/util/DatabaseConnection.java
echo.
echo ========================================
echo QUICK DATABASE COMMANDS:
echo ========================================
echo.
echo To create database and import schema:
echo mysql -u root -p -e "CREATE DATABASE student_management;"
echo mysql -u root -p student_management ^< database/schema.sql
echo.
echo To check if database exists:
echo mysql -u root -p -e "SHOW DATABASES;"
echo.
pause
