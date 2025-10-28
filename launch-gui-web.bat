@echo off
REM Launch Code GUI in web browser on Windows (no system dependencies required)
setlocal enabledelayedexpansion

echo 🌐 Launching Code GUI in web browser...

REM Get script directory
set "SCRIPT_DIR=%~dp0"
set "GUI_DIR=%SCRIPT_DIR%code-gui"

REM Check if GUI dependencies are installed
if not exist "%GUI_DIR%\node_modules" (
    echo 📦 Installing GUI dependencies...
    cd /d "%GUI_DIR%"
    call npm install
)

REM Launch the web server
echo ✨ Starting web server...
echo 📱 Open http://localhost:5173 in your browser
cd /d "%GUI_DIR%"
call npm run dev
