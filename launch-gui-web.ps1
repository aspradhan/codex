# Launch Code GUI in web browser on Windows (PowerShell)
Write-Host "🌐 Launching Code GUI in web browser..." -ForegroundColor Green

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GuiDir = Join-Path $ScriptDir "code-gui"

# Check if GUI dependencies are installed
if (-not (Test-Path (Join-Path $GuiDir "node_modules"))) {
    Write-Host "📦 Installing GUI dependencies..." -ForegroundColor Cyan
    Push-Location $GuiDir
    npm install
    Pop-Location
}

# Launch the web server
Write-Host "✨ Starting web server..." -ForegroundColor Green
Write-Host "📱 Open http://localhost:5173 in your browser" -ForegroundColor Cyan
Push-Location $GuiDir
npm run dev
Pop-Location
