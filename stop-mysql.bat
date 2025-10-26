@echo off
echo Stopping MySQL Database...
echo.

docker-compose -f docker-compose-mysql.yml down

if %errorlevel% equ 0 (
    echo.
    echo ✅ MySQL Database stopped successfully!
    echo.
) else (
    echo.
    echo ❌ Failed to stop MySQL container.
    echo.
)

pause
