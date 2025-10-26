@echo off
echo ========================================
echo  XAMPP MySQL Setup Helper
echo ========================================
echo.

echo This script will help you set up MySQL using XAMPP.
echo.

echo Step 1: Download and Install XAMPP
echo ========================================
echo 1. Go to: https://www.apachefriends.org/download.html
echo 2. Download XAMPP for Windows
echo 3. Install XAMPP (default settings are fine)
echo 4. Start XAMPP Control Panel
echo.

echo Step 2: Start MySQL Service
echo ========================================
echo 1. In XAMPP Control Panel, click "Start" next to MySQL
echo 2. Wait for MySQL to start (green indicator)
echo.

echo Step 3: Create Database
echo ========================================
echo 1. Open phpMyAdmin: http://localhost/phpmyadmin
echo 2. Click "New" to create a new database
echo 3. Database name: student_management
echo 4. Click "Create"
echo.

echo Step 4: Import Schema
echo ========================================
echo 1. Select the student_management database
echo 2. Click "Import" tab
echo 3. Choose file: database/schema.sql
echo 4. Click "Go" to import
echo.

echo Step 5: Update Connection Settings
echo ========================================
echo For XAMPP default settings, update DatabaseConnection.java:
echo - Username: root
echo - Password: (leave empty)
echo.

echo After completing these steps:
echo 1. Build and run your application
echo 2. Login with admin/admin123
echo 3. Your app will now use real database!
echo.

pause
