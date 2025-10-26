@echo off
echo ========================================
echo Student Management System - Tomcat Runner
echo ========================================
echo.

REM Check if Tomcat exists in common locations
set TOMCAT_HOME=
if exist "C:\Program Files\Apache Software Foundation\Tomcat 9.0" set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0
if exist "C:\Program Files\Apache Software Foundation\Tomcat 10.0" set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 10.0
if exist "C:\apache-tomcat-9.0" set TOMCAT_HOME=C:\apache-tomcat-9.0
if exist "C:\apache-tomcat-10.0" set TOMCAT_HOME=C:\apache-tomcat-10.0
if exist "C:\tomcat" set TOMCAT_HOME=C:\tomcat

if "%TOMCAT_HOME%"=="" (
    echo ❌ Tomcat not found!
    echo.
    echo Please install Apache Tomcat:
    echo 1. Download from: https://tomcat.apache.org/download-90.cgi
    echo 2. Extract to C:\apache-tomcat-9.0
    echo 3. Run this script again
    echo.
    pause
    exit /b 1
)

echo ✓ Found Tomcat at: %TOMCAT_HOME%

echo.
echo Step 1: Deploying application...
if exist "%TOMCAT_HOME%\webapps\student-management-system" rmdir /S /Q "%TOMCAT_HOME%\webapps\student-management-system"
xcopy /E /I /Y target\webapp "%TOMCAT_HOME%\webapps\student-management-system\"
echo ✓ Application deployed!

echo.
echo Step 2: Starting Tomcat...
echo Starting Tomcat server...
echo.
echo Once started, access your application at:
echo 🌐 http://localhost:8080/student-management-system/
echo.
echo Default login credentials:
echo 👤 Username: admin
echo 🔑 Password: admin123
echo.
echo Press Ctrl+C to stop the server
echo.

"%TOMCAT_HOME%\bin\startup.bat"

echo.
echo Tomcat started! Check the console for any errors.
echo.
pause
