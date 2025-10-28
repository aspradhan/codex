#!/usr/bin/env bash
# Test GUI setup and components
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GUI_DIR="$SCRIPT_DIR/code-gui"

echo "🧪 Testing GUI Setup..."
echo

# Check directory structure
echo "✓ Checking directory structure..."
for dir in "$GUI_DIR" "$GUI_DIR/src-tauri" "$GUI_DIR/src-tauri/src"; do
    if [ ! -d "$dir" ]; then
        echo "❌ Missing directory: $dir"
        exit 1
    fi
done
echo "  ✓ All directories present"
echo

# Check key files
echo "✓ Checking key files..."
files=(
    "$GUI_DIR/package.json"
    "$GUI_DIR/index.html"
    "$GUI_DIR/main.js"
    "$GUI_DIR/vite.config.js"
    "$GUI_DIR/src-tauri/Cargo.toml"
    "$GUI_DIR/src-tauri/src/lib.rs"
    "$GUI_DIR/src-tauri/tauri.conf.json"
)

for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "  ❌ Missing file: $file"
        exit 1
    fi
done
echo "  ✓ All key files present"
echo

# Check Node.js dependencies
echo "✓ Checking Node.js setup..."
if ! command -v npm &> /dev/null; then
    echo "  ❌ npm not found"
    exit 1
fi
echo "  ✓ npm available: $(npm --version)"
echo

# Test frontend build
echo "✓ Testing frontend build..."
cd "$GUI_DIR"
if [ ! -d "node_modules" ]; then
    echo "  📦 Installing dependencies..."
    npm install --silent
fi

echo "  🔨 Building frontend..."
npm run build > /tmp/gui-build.log 2>&1
if [ $? -eq 0 ]; then
    echo "  ✓ Frontend build successful"
    if [ -f "dist/index.html" ]; then
        echo "  ✓ dist/index.html created"
    else
        echo "  ❌ dist/index.html not found"
        exit 1
    fi
else
    echo "  ❌ Frontend build failed"
    cat /tmp/gui-build.log
    exit 1
fi
echo

# Check launch scripts
echo "✓ Checking launch scripts..."
for script in "$SCRIPT_DIR/launch-gui.sh" "$SCRIPT_DIR/launch-gui-web.sh"; do
    if [ ! -x "$script" ]; then
        echo "  ❌ Not executable: $script"
        exit 1
    fi
done
echo "  ✓ Launch scripts are executable"
echo

# Summary
echo "✅ All GUI components are properly set up!"
echo
echo "To launch the GUI:"
echo "  Native desktop: ./launch-gui.sh"
echo "  Web browser:    ./launch-gui-web.sh"
echo
echo "Note: Native desktop mode requires system GUI libraries."
echo "See code-gui/BUILD.md for system requirements."
