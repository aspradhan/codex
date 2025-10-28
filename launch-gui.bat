@echo off
REM Launch the Code GUI application on Windows
setlocal enabledelayedexpansion

echo 🚀 Launching Code GUI...

REM Get script directory
set "SCRIPT_DIR=%~dp0"
set "GUI_DIR=%SCRIPT_DIR%code-gui"

REM Check if Code binary is built
if not exist "%SCRIPT_DIR%code-rs\target\dev-fast\code.exe" (
    if not exist "%SCRIPT_DIR%code-rs\target\debug\code.exe" (
        if not exist "%SCRIPT_DIR%code-rs\target\release\code.exe" (
            echo ⚠️  Code binary not found. Building...
            call "%SCRIPT_DIR%build-fast.sh"
        )
    )
)

REM Check if GUI dependencies are installed
if not exist "%GUI_DIR%\node_modules" (
    echo 📦 Installing GUI dependencies...
    cd /d "%GUI_DIR%"
    call npm install
)

REM Launch the GUI
echo ✨ Starting GUI application...
cd /d "%GUI_DIR%"
call npm run tauri:dev
