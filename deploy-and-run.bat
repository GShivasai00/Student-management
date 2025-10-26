@echo off
echo ========================================
echo Deploying and Running Application
echo ========================================
echo.

REM Check if Tomcat exists
if not exist "C:\apache-tomcat-9.0" (
    echo ❌ Tomcat not found at C:\apache-tomcat-9.0
    echo Please run download-tomcat.bat first
    pause
    exit /b 1
)

echo Step 1: Deploying application to Tomcat...
if exist "C:\apache-tomcat-9.0\webapps\student-management-system" (
    echo Removing existing deployment...
    rmdir /S /Q "C:\apache-tomcat-9.0\webapps\student-management-system"
)

echo Copying application files...
xcopy /E /I /Y target\webapp "C:\apache-tomcat-9.0\webapps\student-management-system\"
echo ✓ Application deployed!

echo.
echo Step 2: Starting Tomcat server...
echo.
echo 🌐 Your application will be available at:
echo    http://localhost:8080/student-management-system/
echo.
echo 👤 Default login credentials:
echo    Username: admin
echo    Password: admin123
echo.
echo ⚠️  IMPORTANT: Make sure MySQL is running!
echo    - Install MySQL Server
echo    - Create database: student_management
echo    - Run: database\schema.sql
echo.
echo Press Ctrl+C to stop the server
echo.

"C:\apache-tomcat-9.0\bin\startup.bat"

echo.
echo Tomcat started! Check the console for any errors.
echo If you see errors, make sure MySQL is running and configured.
echo.
pause
