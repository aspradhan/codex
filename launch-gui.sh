#!/usr/bin/env bash
# Launch the Code GUI application
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GUI_DIR="$SCRIPT_DIR/code-gui"

echo "🚀 Launching Code GUI..."

# Check if Code binary is built
if [ ! -f "$SCRIPT_DIR/code-rs/target/dev-fast/code" ] && \
   [ ! -f "$SCRIPT_DIR/code-rs/target/debug/code" ] && \
   [ ! -f "$SCRIPT_DIR/code-rs/target/release/code" ]; then
    echo "⚠️  Code binary not found. Building..."
    "$SCRIPT_DIR/build-fast.sh"
fi

# Check if GUI dependencies are installed
if [ ! -d "$GUI_DIR/node_modules" ]; then
    echo "📦 Installing GUI dependencies..."
    cd "$GUI_DIR"
    npm install
fi

# Launch the GUI
echo "✨ Starting GUI application..."
cd "$GUI_DIR"
npm run tauri:dev
