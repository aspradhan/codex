#!/usr/bin/env bash
# Launch Code GUI in web browser (no system dependencies required)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GUI_DIR="$SCRIPT_DIR/code-gui"

echo "🌐 Launching Code GUI in web browser..."

# Check if GUI dependencies are installed
if [ ! -d "$GUI_DIR/node_modules" ]; then
    echo "📦 Installing GUI dependencies..."
    cd "$GUI_DIR"
    npm install
fi

# Launch the web server
echo "✨ Starting web server..."
echo "📱 Open http://localhost:5173 in your browser"
cd "$GUI_DIR"
npm run dev
