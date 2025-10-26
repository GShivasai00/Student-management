@echo off
echo ========================================
echo  Student Management System Build & Run
echo ========================================
echo.

REM Set error handling
setlocal enabledelayedexpansion

echo Step 1: Clean Previous Build
echo ========================================
if exist "target" rmdir /s /q "target"
if exist "build" rmdir /s /q "build"
echo ✅ Cleaned previous build

echo.
echo Step 2: Create Build Directory
echo ========================================
mkdir build\classes 2>nul
mkdir build\lib 2>nul
mkdir build\webapp 2>nul
echo ✅ Created build directories

echo.
echo Step 3: Download Dependencies (if needed)
echo ========================================
if not exist "lib\mysql-connector-java-8.0.33.jar" (
    echo Downloading MySQL Connector...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar' -OutFile 'lib\mysql-connector-java-8.0.33.jar'"
)

if not exist "lib\servlet-api.jar" (
    echo Downloading Servlet API...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar' -OutFile 'lib\servlet-api.jar'"
)

if not exist "lib\jsp-api.jar" (
    echo Downloading JSP API...
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/javax/servlet/jsp/javax.servlet.jsp-api/2.3.3/javax.servlet.jsp-api-2.3.3.jar' -OutFile 'lib\jsp-api.jar'"
)

echo ✅ Dependencies ready

echo.
echo Step 4: Compile Java Sources
echo ========================================
javac -cp "lib\*" -d build\classes src\main\java\com\studentmanagement\model\*.java
if %errorlevel% neq 0 (
    echo ❌ Model compilation failed
    pause
    exit /b 1
)

javac -cp "lib\*;build\classes" -d build\classes src\main\java\com\studentmanagement\dao\*.java
if %errorlevel% neq 0 (
    echo ❌ DAO compilation failed
    pause
    exit /b 1
)

javac -cp "lib\*;build\classes" -d build\classes src\main\java\com\studentmanagement\util\*.java
if %errorlevel% neq 0 (
    echo ❌ Util compilation failed
    pause
    exit /b 1
)

javac -cp "lib\*;build\classes" -d build\classes src\main\java\com\studentmanagement\servlet\*.java
if %errorlevel% neq 0 (
    echo ❌ Servlet compilation failed
    pause
    exit /b 1
)

echo ✅ Java compilation successful

echo.
echo Step 5: Copy Web Resources
echo ========================================
xcopy /E /I /Y src\main\webapp\* build\webapp\
echo ✅ Web resources copied

echo.
echo Step 6: Copy Compiled Classes
echo ========================================
xcopy /E /Y build\classes\* build\webapp\WEB-INF\classes\
echo ✅ Classes copied to WEB-INF

echo.
echo Step 7: Copy Dependencies
echo ========================================
copy lib\*.jar build\webapp\WEB-INF\lib\
echo ✅ Dependencies copied

echo.
echo Step 8: Create WAR File
echo ========================================
cd build\webapp
jar -cf ..\student-management-system.war *
cd ..\..
echo ✅ WAR file created

echo.
echo Step 9: Deploy to Tomcat
echo ========================================
if exist "C:\apache-tomcat-9.0.80\webapps\student-management-system" (
    rmdir /s /q "C:\apache-tomcat-9.0.80\webapps\student-management-system"
)
copy build\student-management-system.war "C:\apache-tomcat-9.0.80\webapps\"
echo ✅ Application deployed to Tomcat

echo.
echo Step 10: Start Tomcat
echo ========================================
echo Starting Tomcat server...
start "Tomcat Server" "C:\apache-tomcat-9.0.80\bin\startup.bat"

echo.
echo ========================================
echo  Build and Deployment Complete!
echo ========================================
echo.
echo Your application is now running at:
echo http://localhost:8080/student-management-system
echo.
echo Default login: admin/admin123
echo.
echo If you encounter any issues:
echo 1. Check if MySQL is running
echo 2. Verify database password in DatabaseConnection.java
echo 3. Run setup-mysql-database.bat if needed
echo.

pause
