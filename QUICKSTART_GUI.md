# Quick Start: Code GUI

Want to use Code with a graphical interface instead of the terminal? Here's how!

## Two Ways to Launch

### 1. Desktop App (Recommended)
Native window with all features:

**macOS / Linux:**
```bash
./launch-gui.sh
```

**Windows (PowerShell):**
```powershell
.\launch-gui.ps1
```

**Windows (Command Prompt):**
```cmd
launch-gui.bat
```

**Note**: On Linux, you need GUI libraries first:
```bash
sudo apt install libwebkit2gtk-4.1-dev libgtk-3-dev
```

### 2. Web Browser (No Installation)
No system libraries needed:

**macOS / Linux:**
```bash
./launch-gui-web.sh
```

**Windows (PowerShell):**
```powershell
.\launch-gui-web.ps1
```

**Windows (Command Prompt):**
```cmd
launch-gui-web.bat
```

Then open http://localhost:5173

## What You Get

### GUI Mode Shows:
```
┌─────────────────────────────────────────┐
│ Code - AI Coding Assistant         ─ □ × │
├─────────────────────────────────────────┤
│ [📄 New] [📁 Open] [⚙️ Settings] [🎨 Themes] │
├─────────────────────────────────────────┤
│                                         │
│  Your familiar Code interface here!    │
│  (Same TUI you know and love)          │
│                                         │
└─────────────────────────────────────────┘
```

### Click These Buttons:
- **📄 New Session** - Start fresh conversation
- **📁 Open** - Search for files
- **⚙️ Settings** - Change preferences  
- **🎨 Themes** - Pick a new look
- **❓ Help** - Get assistance

Or just type commands like always!

## Still Want Terminal?

No problem! The CLI still works:
```bash
code
```

Both modes do exactly the same thing - pick what you prefer!

## Npm Scripts

From the repo root:
```bash
npm run gui:install   # Install GUI dependencies
npm run gui:dev       # Run in web browser
npm run gui:tauri     # Run as desktop app
npm run gui:test      # Verify setup
```

## Need Help?

- 📖 Full guide: `code-gui/README.md`
- 🔧 Installation: `code-gui/INSTALL.md`
- 🏗️ Architecture: `docs/GUI_CONVERSION.md`
- ✅ Test setup: `./test-gui-setup.sh`

## That's It!

You're ready to use Code with a GUI. Enjoy! 🎉
