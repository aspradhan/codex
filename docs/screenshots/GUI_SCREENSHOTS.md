# Code GUI Screenshots

## Desktop Window with Toolbar

```
┌────────────────────────────────────────────────────────────────┐
│ Code - AI Coding Assistant                               ─ □ × │
├────────────────────────────────────────────────────────────────┤
│ 📄 New Session | 📁 Open | ⚙️ Settings | 🎨 Themes |    ❓ Help │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  [Terminal displays Code TUI here]                            │
│                                                                │
│  What can I code for you today?                               │
│                                                                │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │ > _                                                      │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                                │
├────────────────────────────────────────────────────────────────┤
│ 🤖 Code AI Coding Assistant                          Ready     │
└────────────────────────────────────────────────────────────────┘
```

## Features Visible in GUI

- **Native window chrome** - Standard title bar, minimize/maximize/close buttons
- **Toolbar** - Quick access buttons for common commands
- **Terminal view** - Full Code TUI with all features
- **Status bar** - Connection status and indicators
- **Responsive** - Resizable window, terminal adapts automatically

## Comparison: CLI vs GUI

### CLI Mode (Terminal)
```bash
$ code
[TUI launches in full terminal]
```

### GUI Mode (Desktop Window)
```bash
$ ./launch-gui.sh
[Opens in native desktop window with toolbar]
```

Both modes provide identical functionality - the GUI just adds:
- Point-and-click toolbar buttons
- Native window appearance  
- Better integration with desktop environment

## Coming Soon

Actual screenshots will be added once the application is tested on various platforms.

To see it in action, run:
```bash
./launch-gui-web.sh
```

Then open http://localhost:5173 in your browser.
