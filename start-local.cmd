@echo off
setlocal EnableExtensions

rem Windows Explorer double-click entry point. The actual startup work runs in WSL.
set "PROJECT_DIR=%~dp0"
for %%I in ("%PROJECT_DIR%.") do set "PROJECT_DIR=%%~fI"

where wsl.exe >nul 2>&1
if errorlevel 1 (
  echo [LeetRecall] WSL was not found. Install WSL first and run this file again.
  set "EXIT_CODE=1"
  goto :finish
)

echo [LeetRecall] Starting local services in WSL...
wsl.exe --cd "%PROJECT_DIR%" bash ./scripts/start-local.sh
set "EXIT_CODE=%ERRORLEVEL%"

if not "%EXIT_CODE%"=="0" (
  echo [LeetRecall] Startup failed. Review the message above and try again.
) else (
  echo [LeetRecall] Startup command finished successfully.
)

:finish
if "%LEETRECALL_NO_PAUSE%"=="1" exit /b %EXIT_CODE%
echo.
pause
exit /b %EXIT_CODE%
