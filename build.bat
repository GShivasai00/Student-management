@echo off
echo Building Student Management System...

REM Create directories
if not exist "target\classes" mkdir target\classes
if not exist "target\lib" mkdir target\lib

REM Download dependencies manually (you'll need to do this)
echo Please download these JAR files to target\lib\:
echo - javax.servlet-api-4.0.1.jar
echo - javax.servlet.jsp-api-2.3.3.jar
echo - jstl-1.2.jar
echo - mysql-connector-java-8.0.33.jar
echo - jackson-databind-2.15.2.jar

REM Compile Java files
echo Compiling Java files...
javac -cp "target\lib\*" -d target\classes src\main\java\com\studentmanagement\*.java src\main\java\com\studentmanagement\*\*.java

if %ERRORLEVEL% NEQ 0 (
    echo Compilation failed!
    pause
    exit /b 1
)

echo Compilation successful!
echo.
echo To run the application:
echo 1. Install Apache Tomcat
echo 2. Copy the webapp folder to Tomcat's webapps directory
echo 3. Start Tomcat server
echo 4. Access: http://localhost:8080/student-management-system/

pause
