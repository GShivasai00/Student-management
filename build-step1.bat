@echo off
echo ========================================
echo Student Management System - Manual Build
echo ========================================
echo.

REM Create necessary directories
if not exist "target\classes" mkdir target\classes
if not exist "target\lib" mkdir target\lib
if not exist "target\webapp" mkdir target\webapp

echo Step 1: Creating directory structure...
echo ✓ Directories created

echo.
echo Step 2: Downloading required JAR files...
echo Please download these files manually to target\lib\ folder:

echo.
echo 1. Servlet API:
echo    https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar
echo.
echo 2. JSP API:
echo    https://repo1.maven.org/maven2/javax/servlet/jsp/javax.servlet.jsp-api/2.3.3/javax.servlet.jsp-api-2.3.3.jar
echo.
echo 3. JSTL:
echo    https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar
echo.
echo 4. MySQL Connector:
echo    https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar
echo.
echo 5. Jackson:
echo    https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.2/jackson-databind-2.15.2.jar

echo.
echo After downloading the JAR files, run: build-step2.bat
echo.
pause
