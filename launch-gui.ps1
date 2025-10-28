# Launch the Code GUI application on Windows (PowerShell)
Write-Host "🚀 Launching Code GUI..." -ForegroundColor Green

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GuiDir = Join-Path $ScriptDir "code-gui"

# Check if Code binary is built
$codePaths = @(
    (Join-Path $ScriptDir "code-rs\target\dev-fast\code.exe"),
    (Join-Path $ScriptDir "code-rs\target\debug\code.exe"),
    (Join-Path $ScriptDir "code-rs\target\release\code.exe")
)

$codeExists = $false
foreach ($path in $codePaths) {
    if (Test-Path $path) {
        $codeExists = $true
        break
    }
}

if (-not $codeExists) {
    Write-Host "⚠️  Code binary not found. Building..." -ForegroundColor Yellow
    & (Join-Path $ScriptDir "build-fast.sh")
}

# Check if GUI dependencies are installed
if (-not (Test-Path (Join-Path $GuiDir "node_modules"))) {
    Write-Host "📦 Installing GUI dependencies..." -ForegroundColor Cyan
    Push-Location $GuiDir
    npm install
    Pop-Location
}

# Launch the GUI
Write-Host "✨ Starting GUI application..." -ForegroundColor Green
Push-Location $GuiDir
npm run tauri:dev
Pop-Location
