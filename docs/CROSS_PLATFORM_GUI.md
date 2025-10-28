# Cross-Platform GUI Support

Code GUI now supports Windows, macOS, and Linux with platform-specific launch scripts and native builds.

## Platform Support Matrix

| Platform | Desktop App | Web Mode | Requirements |
|----------|-------------|----------|--------------|
| **Windows** | ✅ | ✅ | WebView2 (built into Windows 10/11) |
| **macOS** | ✅ | ✅ | None |
| **Linux** | ✅ | ✅ | WebKit2GTK, GTK3 |

## Quick Launch

### Windows

**PowerShell (Recommended):**
```powershell
# Desktop app
.\launch-gui.ps1

# Web mode
.\launch-gui-web.ps1
```

**Command Prompt:**
```cmd
REM Desktop app
launch-gui.bat

REM Web mode
launch-gui-web.bat
```

**Git Bash / WSL:**
```bash
# Desktop app
./launch-gui.sh

# Web mode
./launch-gui-web.sh
```

### macOS

```bash
# Desktop app
./launch-gui.sh

# Web mode
./launch-gui-web.sh
```

### Linux

```bash
# Install dependencies first (Ubuntu/Debian)
sudo apt install -y libwebkit2gtk-4.1-dev libgtk-3-dev build-essential libssl-dev

# Desktop app
./launch-gui.sh

# Web mode
./launch-gui-web.sh
```

## Building Platform-Specific Installers

### Windows

```bash
cd code-gui
npm install
npm run tauri:build
```

Output: `src-tauri/target/release/bundle/msi/Code_0.1.0_x64_en-US.msi`

### macOS

```bash
cd code-gui
npm install
npm run tauri:build
```

Output: `src-tauri/target/release/bundle/macos/Code.app`

### Linux

```bash
cd code-gui
npm install
npm run tauri:build
```

Outputs:
- `src-tauri/target/release/bundle/deb/code-gui_0.1.0_amd64.deb`
- `src-tauri/target/release/bundle/appimage/code-gui_0.1.0_amd64.AppImage`

## Platform-Specific Features

### Windows
- **WebView2**: Built into Windows 10/11, no installation needed
- **MSI Installer**: Standard Windows installer format
- **Portable**: Can run standalone `.exe` from bundle directory
- **Start Menu**: Automatic integration after MSI install

### macOS
- **Code Signing**: Can be added for distribution (requires Apple Developer account)
- **DMG Installer**: Coming soon (currently builds .app bundle)
- **Notarization**: Optional for distribution outside App Store
- **Dock Integration**: Native macOS application experience

### Linux
- **DEB Package**: For Debian/Ubuntu-based distributions
- **AppImage**: Universal format that works on most distributions
- **Desktop Integration**: `.desktop` file for application menu
- **Multiple Formats**: RPM support coming soon

## System Requirements

### All Platforms
- Node.js 20+
- npm or compatible package manager
- Code binary built (automatically checked by launch scripts)

### Windows-Specific
- Windows 10 or later (for WebView2)
- Visual Studio Build Tools (for building from source)

### macOS-Specific
- macOS 10.13 (High Sierra) or later
- Xcode Command Line Tools

### Linux-Specific
- WebKit2GTK 2.24+
- GTK 3.22+
- GCC/Clang compiler

## Development Mode vs Production

### Development Mode
- Launch scripts run `npm run tauri:dev`
- Hot reload enabled for frontend changes
- Debug logging active
- Faster iteration cycle

### Production Build
- Run `npm run tauri:build`
- Optimized bundles
- Platform-specific installers created
- Smaller file size, better performance

## npm Scripts (Cross-Platform)

All npm scripts work on all platforms:

```bash
# From repository root
npm run gui:install      # Install GUI dependencies
npm run gui:dev          # Web development mode
npm run gui:tauri        # Desktop development mode
npm run gui:build        # Build frontend
npm run gui:tauri:build  # Build desktop app with installer
npm run gui:test         # Verify setup
```

## Troubleshooting by Platform

### Windows
**Issue**: PowerShell script won't run
- **Solution**: Run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`

**Issue**: WebView2 not found
- **Solution**: Update Windows or install WebView2 Runtime from Microsoft

### macOS
**Issue**: "Code.app is damaged and can't be opened"
- **Solution**: Run `xattr -cr Code.app` or right-click and select Open

**Issue**: Permission denied on launch script
- **Solution**: Run `chmod +x launch-gui.sh`

### Linux
**Issue**: WebKit2GTK not found
- **Solution**: Install system dependencies (see Quick Launch section)

**Issue**: AppImage won't run
- **Solution**: Make executable: `chmod +x code-gui_*.AppImage`

## Best Practices

1. **Use platform-native scripts**: PowerShell/batch on Windows, shell scripts on Unix
2. **Test on target platform**: Each platform has unique behaviors
3. **Include dependencies**: Windows users may need WebView2, Linux needs system libs
4. **Provide multiple formats**: MSI for Windows, .app for macOS, DEB/AppImage for Linux
5. **Document platform differences**: Note what works where in your README

## CI/CD Considerations

For automated builds across platforms:

```yaml
# GitHub Actions example
strategy:
  matrix:
    platform: [ubuntu-latest, windows-latest, macos-latest]
```

See `.github/workflows/` for full examples (to be added).

## Distribution

### Windows
- Microsoft Store (requires developer account)
- Direct download (.msi)
- Winget package manager
- Chocolatey

### macOS
- Mac App Store (requires developer account)
- Direct download (.dmg)
- Homebrew Cask

### Linux
- Snap Store
- Flathub
- Distribution repositories (apt, rpm)
- Direct download (AppImage, .deb)

## Future Enhancements

- [ ] ARM64 builds for Apple Silicon and Windows ARM
- [ ] Auto-update functionality per platform
- [ ] Platform-specific UI adaptations
- [ ] Native file dialogs
- [ ] System tray integration
- [ ] Platform-specific shortcuts and conventions

## Getting Help

Platform-specific issues:
- Windows: Check Event Viewer for application errors
- macOS: Check Console.app for crash logs
- Linux: Check `journalctl` or `~/.local/share/Code/logs/`

General support: See main README.md or open an issue on GitHub.
