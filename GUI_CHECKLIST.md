# GUI Mode Checklist

Use this checklist to get Code GUI running on your system.

## Prerequisites

- [ ] Code repository cloned
- [ ] Node.js 20+ installed (`node --version`)
- [ ] npm available (`npm --version`)

## Quick Test (Web Mode)

No system libraries needed!

- [ ] Run: `./launch-gui-web.sh`
- [ ] Open: http://localhost:5173
- [ ] See: GUI interface with toolbar
- [ ] Click: "New Session" button
- [ ] Verify: Interface responds

✅ If this works, your frontend is good!

## Desktop Mode (Optional)

### macOS
- [ ] No extra dependencies needed
- [ ] Run: `./launch-gui.sh`
- [ ] See: Native desktop window

### Linux
- [ ] Install libraries:
  ```bash
  sudo apt install -y \
      libwebkit2gtk-4.1-dev \
      libgtk-3-dev \
      build-essential \
      libssl-dev
  ```
- [ ] Run: `./launch-gui.sh`
- [ ] See: Native desktop window

### Windows
- [ ] No extra dependencies needed (uses WebView2)
- [ ] PowerShell: `.\launch-gui.ps1`
- [ ] Or Command Prompt: `launch-gui.bat`
- [ ] See: Native desktop window

## Verify Installation

- [ ] Run: `./test-gui-setup.sh`
- [ ] See: All checks pass ✅

## Using npm Scripts

From repository root:
- [ ] `npm run gui:install` - Install dependencies
- [ ] `npm run gui:test` - Verify setup
- [ ] `npm run gui:dev` - Web mode
- [ ] `npm run gui:tauri` - Desktop mode

## Troubleshooting

### "npm not found"
- Install Node.js from https://nodejs.org/

### "WebKit2GTK not found" (Linux only)
- Run the Linux install commands above
- Or use web mode: `./launch-gui-web.sh`

### "Failed to start code process"
- Build Code first: `./build-fast.sh`
- This can take 20+ minutes on first run

### Port 5173 already in use
- Stop other Vite servers
- Or change port in `code-gui/vite.config.js`

## Next Steps

Once working:
- [ ] Read: `QUICKSTART_GUI.md` - Quick usage guide
- [ ] Read: `code-gui/README.md` - Full documentation
- [ ] Try: Toolbar buttons for common commands
- [ ] Explore: All CLI features work in GUI too!

## Getting Help

If stuck, check:
1. `code-gui/BUILD.md` - System requirements
2. `code-gui/INSTALL.md` - Installation details
3. `docs/GUI_CONVERSION.md` - Architecture
4. GitHub Issues - Report problems

## Success! 🎉

If you see the GUI window with toolbar and terminal:
- ✅ Installation complete
- ✅ Ready to use
- ✅ Both CLI and GUI modes available

Enjoy using Code with a graphical interface!
