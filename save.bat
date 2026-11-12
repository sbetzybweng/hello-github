@echo off
setlocal enabledelayedexpansion
set GIT_TERMINAL_PROMPT=0
set "RC=0"
cd /d "%~dp0"
if errorlevel 1 goto :fail

echo.
echo ==========================================
echo   Save to GitHub - sbetzybweng/hello-github
echo ==========================================
echo.

set "MSG=Auto save %date:~0,10% %time:~0,8%"
if not "%~1"=="" set "MSG=%~1"

echo [1/4] Checking repository...
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 goto :nogit

echo [2/4] Staging changes...
git add -A
if errorlevel 1 goto :fail

git diff --cached --quiet
if errorlevel 1 (
  echo [3/4] Committing: !MSG!
  git commit -m "!MSG!"
  if errorlevel 1 goto :fail
) else (
  echo [3/4] No local changes, skip commit.
)

echo [4/4] Pushing to GitHub...
git push origin main
if not errorlevel 1 goto :success
echo     Network glitch, retry in 3 seconds...
ping -n 4 127.0.0.1 >nul 2>&1
git push origin main
if errorlevel 1 goto :fail

:success
echo.
echo SUCCESS - files are now on GitHub.
echo https://github.com/sbetzybweng/hello-github
goto :end

:nogit
set "RC=1"
echo ERROR - this folder is not a git repository.
goto :end

:fail
set "RC=1"
echo.
echo FAILED - see messages above. Check network, then try again.
goto :end

:end
echo.
pause
exit /b %RC%
