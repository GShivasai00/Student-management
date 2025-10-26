@echo off
echo ========================================
echo Student Management System - Setup Guide
echo ========================================
echo.
echo ✅ APPLICATION BUILT SUCCESSFULLY!
echo.
echo Your application is ready in: target\webapp\
echo.
echo ========================================
echo NEXT STEPS TO RUN THE APPLICATION:
echo ========================================
echo.
echo 1. DATABASE SETUP:
echo    - Install MySQL Server
echo    - Create database: student_management
echo    - Run: database\schema.sql
echo.
echo 2. TOMCAT SETUP:
echo    - Download Apache Tomcat 9.0 or 10.0
echo    - Extract to C:\apache-tomcat-9.0
echo    - Copy target\webapp to C:\apache-tomcat-9.0\webapps\
echo    - Rename it to 'student-management-system'
echo.
echo 3. RUN APPLICATION:
echo    - Start Tomcat: C:\apache-tomcat-9.0\bin\startup.bat
echo    - Access: http://localhost:8080/student-management-system/
echo    - Login: admin / admin123
echo.
echo ========================================
echo QUICK START OPTIONS:
echo ========================================
echo.
echo Option A: Download Tomcat automatically
echo   Run: download-tomcat.bat
echo.
echo Option B: Use existing Tomcat
echo   Run: run-tomcat.bat
echo.
echo Option C: Manual setup
echo   Follow the steps above
echo.
echo ========================================
echo DATABASE CONFIGURATION:
echo ========================================
echo.
echo Update DatabaseConnection.java with your MySQL password:
echo   File: src\main\java\com\studentmanagement\util\DatabaseConnection.java
echo   Line: private static final String DB_PASSWORD = "your_password";
echo.
echo Then rebuild: javac -cp "target\lib\*" -d target\classes src\main\java\com\studentmanagement\*\*.java
echo.
pause
