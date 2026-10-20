@echo off
setlocal
title Push-Up Counter
cd /d "%~dp0"
set PORT=8095

rem The camera only works on localhost or HTTPS, so serve this folder locally.
set PY=
where python >nul 2>nul && set PY=python
if not defined PY where py >nul 2>nul && set PY=py
if not defined PY (
  echo Python was not found. Install it from https://www.python.org/downloads/ and run START.bat again.
  pause
  exit /b 1
)

echo.
echo   Push-Up Counter is running at http://localhost:%PORT%
echo   Keep this window open while you work out. Close it to stop the app.
echo.
echo   On your phone, skip this window: open https://eqwaak-27.github.io/pushup-counter/
echo   in Chrome or Safari and allow the camera. History is saved on the phone itself.
echo.

rem open the browser a moment after the server starts
start "" /b cmd /c "timeout /t 1 /nobreak >nul & start "" http://localhost:%PORT%"
%PY% -m http.server %PORT% --bind 127.0.0.1
if errorlevel 1 (
  echo.
  echo Could not start the server. Is port %PORT% already in use? If the app is already open, just use that tab.
  pause
)
