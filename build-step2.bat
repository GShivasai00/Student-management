@echo off
echo ========================================
echo Student Management System - Compilation
echo ========================================
echo.

REM Check if JAR files exist
if not exist "target\lib\javax.servlet-api-4.0.1.jar" (
    echo ERROR: javax.servlet-api-4.0.1.jar not found!
    echo Please run build-step1.bat first and download the required JAR files.
    pause
    exit /b 1
)

if not exist "target\lib\mysql-connector-java-8.0.33.jar" (
    echo ERROR: mysql-connector-java-8.0.33.jar not found!
    echo Please run build-step1.bat first and download the required JAR files.
    pause
    exit /b 1
)

echo Step 1: Compiling Java source files...
javac -cp "target\lib\*" -d target\classes src\main\java\com\studentmanagement\*.java src\main\java\com\studentmanagement\*\*.java

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ❌ Compilation failed!
    echo Please check the error messages above.
    pause
    exit /b 1
)

echo ✓ Java files compiled successfully!

echo.
echo Step 2: Copying web resources...
xcopy /E /I /Y src\main\webapp\* target\webapp\
echo ✓ Web resources copied!

echo.
echo Step 3: Copying compiled classes...
xcopy /E /I /Y target\classes\* target\webapp\WEB-INF\classes\
echo ✓ Classes copied!

echo.
echo Step 4: Copying JAR files...
xcopy /Y target\lib\* target\webapp\WEB-INF\lib\
echo ✓ JAR files copied!

echo.
echo ========================================
echo ✅ BUILD SUCCESSFUL!
echo ========================================
echo.
echo Your application is ready in: target\webapp\
echo.
echo Next steps:
echo 1. Install Apache Tomcat
echo 2. Copy target\webapp folder to Tomcat's webapps directory
echo 3. Rename it to 'student-management-system'
echo 4. Start Tomcat
echo 5. Access: http://localhost:8080/student-management-system/
echo.
echo Or run: run-tomcat.bat (if Tomcat is installed)
echo.
pause
