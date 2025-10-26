@echo off
echo ========================================
echo  Student Management System Error Fix
echo ========================================
echo.

echo This script will help identify and fix common issues.
echo.

echo Step 1: Checking Java Installation
echo ========================================
java -version
if %errorlevel% neq 0 (
    echo ❌ Java is not installed or not in PATH
    echo Please install Java JDK 11 or higher
    pause
    exit /b 1
)
echo ✅ Java is installed

echo.
echo Step 2: Checking Project Structure
echo ========================================
if not exist "src\main\java\com\studentmanagement\model\Student.java" (
    echo ❌ Student.java model is missing
    echo Please ensure all model classes are present
    pause
    exit /b 1
)
echo ✅ Project structure looks good

echo.
echo Step 3: Checking Database Connection
echo ========================================
echo Testing database connection...
javac -cp "src/main/java" src/main/java/com/studentmanagement/test/DatabaseTest.java
if %errorlevel% neq 0 (
    echo ❌ Compilation failed
    echo Please check your Java code for syntax errors
    pause
    exit /b 1
)

java -cp "src/main/java" com.studentmanagement.test.DatabaseTest
if %errorlevel% neq 0 (
    echo ❌ Database connection test failed
    echo Please check your MySQL installation and password
    echo.
    echo Common fixes:
    echo 1. Make sure MySQL service is running
    echo 2. Update password in DatabaseConnection.java
    echo 3. Run setup-mysql-database.bat to create database
    echo.
    pause
    exit /b 1
)

echo.
echo Step 4: Checking Tomcat Installation
echo ========================================
if not exist "C:\apache-tomcat-9.0.80\bin\startup.bat" (
    echo ❌ Tomcat not found at C:\apache-tomcat-9.0.80
    echo Please install Tomcat or update the path in scripts
    pause
    exit /b 1
)
echo ✅ Tomcat installation found

echo.
echo Step 5: Checking Port Availability
echo ========================================
netstat -an | findstr ":8080" | findstr "LISTENING"
if %errorlevel% equ 0 (
    echo ⚠️  Port 8080 is already in use
    echo Please stop any application using port 8080
    echo Or change the port in Tomcat configuration
    echo.
) else (
    echo ✅ Port 8080 is available
)

echo.
echo ========================================
echo  Error Resolution Summary
echo ========================================
echo.
echo If you're still having issues, try these steps:
echo.
echo 1. Database Issues:
echo    - Run: setup-mysql-database.bat
echo    - Update password in DatabaseConnection.java
echo    - Ensure MySQL service is running
echo.
echo 2. Compilation Issues:
echo    - Check Java version (need JDK 11+)
echo    - Verify all source files are present
echo    - Check for syntax errors in code
echo.
echo 3. Runtime Issues:
echo    - Ensure Tomcat is properly installed
echo    - Check port 8080 is available
echo    - Verify web.xml configuration
echo.
echo 4. IDE Issues:
echo    - Refresh/reimport project
echo    - Clean and rebuild project
echo    - Check classpath configuration
echo.

pause
