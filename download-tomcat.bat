@echo off
echo ========================================
echo Downloading Apache Tomcat
echo ========================================
echo.

REM Create tomcat directory
if not exist "C:\apache-tomcat-9.0" mkdir C:\apache-tomcat-9.0

echo Downloading Apache Tomcat 9.0...
echo This may take a few minutes...
echo.

powershell -Command "Invoke-WebRequest -Uri 'https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.80/bin/apache-tomcat-9.0.80.zip' -OutFile 'C:\apache-tomcat-9.0.zip'"

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to download Tomcat
    echo Please download manually from: https://tomcat.apache.org/download-90.cgi
    pause
    exit /b 1
)

echo ✓ Tomcat downloaded successfully!

echo.
echo Extracting Tomcat...
powershell -Command "Expand-Archive -Path 'C:\apache-tomcat-9.0.zip' -DestinationPath 'C:\' -Force"

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to extract Tomcat
    pause
    exit /b 1
)

echo ✓ Tomcat extracted successfully!

echo.
echo Cleaning up...
del C:\apache-tomcat-9.0.zip

echo.
echo ========================================
echo ✅ TOMCAT INSTALLED SUCCESSFULLY!
echo ========================================
echo.
echo Tomcat location: C:\apache-tomcat-9.0\
echo.
echo Now run: deploy-and-run.bat
echo.
pause
