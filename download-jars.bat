@echo off
echo ========================================
echo Downloading Required JAR Files
echo ========================================
echo.

REM Create lib directory
if not exist "target\lib" mkdir target\lib

echo Downloading JAR files...
echo.

echo 1/5 Downloading Servlet API...
powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar' -OutFile 'target\lib\javax.servlet-api-4.0.1.jar'"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to download Servlet API
    goto :error
)
echo ✓ Servlet API downloaded

echo.
echo 2/5 Downloading JSP API...
powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/javax/servlet/jsp/javax.servlet.jsp-api/2.3.3/javax.servlet.jsp-api-2.3.3.jar' -OutFile 'target\lib\javax.servlet.jsp-api-2.3.3.jar'"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to download JSP API
    goto :error
)
echo ✓ JSP API downloaded

echo.
echo 3/5 Downloading JSTL...
powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar' -OutFile 'target\lib\jstl-1.2.jar'"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to download JSTL
    goto :error
)
echo ✓ JSTL downloaded

echo.
echo 4/5 Downloading MySQL Connector...
powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar' -OutFile 'target\lib\mysql-connector-java-8.0.33.jar'"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to download MySQL Connector
    goto :error
)
echo ✓ MySQL Connector downloaded

echo.
echo 5/5 Downloading Jackson...
powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.15.2/jackson-databind-2.15.2.jar' -OutFile 'target\lib\jackson-databind-2.15.2.jar'"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to download Jackson
    goto :error
)
echo ✓ Jackson downloaded

echo.
echo ========================================
echo ✅ ALL JAR FILES DOWNLOADED SUCCESSFULLY!
echo ========================================
echo.
echo Now run: build-step2.bat
echo.
pause
exit /b 0

:error
echo.
echo ❌ Download failed! Please check your internet connection.
echo You can manually download the JAR files and place them in target\lib\
echo.
pause
exit /b 1
