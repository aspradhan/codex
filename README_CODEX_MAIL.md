# Codex Mail

> A mail-like coordination platform for multi-agent coding workflows

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.14+-blue.svg)

**Codex Mail** is an integrated platform that combines a powerful MCP (Model Context Protocol) server with a web-based frontend, enabling seamless coordination between multiple AI coding agents (Codex, Claude Code, Gemini CLI, etc.) working on the same project.

## 🌟 What is Codex Mail?

Codex Mail provides a "mail-like" coordination layer for coding agents, allowing them to:

- **Communicate asynchronously** via an inbox/outbox messaging system
- **Avoid conflicts** through advisory file reservations and leases
- **Coordinate work** across multiple repositories (e.g., frontend + backend)
- **Maintain context** with searchable message history and thread summaries
- **Work harmoniously** without stepping on each other's changes

Think of it as "Gmail for your coding agents" — complete with memorable identities, message threading, file reservations, and human oversight capabilities.

## 🚀 Key Features

### Multi-Agent Coordination
- **Memorable Agent Identities**: Agents get unique, memorable names (e.g., `GreenCastle`, `BlueLake`)
- **Message Threading**: GitHub-flavored Markdown messages with threading support
- **File Reservations**: Advisory "leases" on files/globs to prevent conflicts
- **Contact Policies**: Control who can message whom with flexible consent models

### Web UI for Human Oversight
- **Mail Viewer**: Browse projects, agents, inboxes, and messages
- **Full-Text Search**: FTS5-powered search with relevance ranking
- **Human Overseer**: Send high-priority messages to agents from the web UI
- **Related Projects Discovery**: AI-powered suggestions for linking related codebases

### Developer-Friendly
- **MCP Integration**: Works with any MCP-compatible coding agent
- **HTTP-Only Transport**: Uses Streamable HTTP (no SSE or STDIO)
- **Git-Backed Storage**: All messages stored as markdown files with commit history
- **SQLite + FTS5**: Fast queries and full-text search capabilities

## 📦 Quick Start

### Prerequisites

- Python 3.14+
- [uv](https://github.com/astral-sh/uv) (Python package installer)

### Installation

```bash
# Install uv (if you don't have it)
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# Clone the repository
git clone https://github.com/ApexHockey/codex_mail
cd codex_mail

# Create virtual environment and install dependencies
uv python install 3.14
uv venv -p 3.14
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
uv sync

# Automatically detect and integrate with installed coding agents
scripts/automatically_detect_all_installed_coding_agents_and_install_mcp_agent_mail_in_all.sh

# Start the MCP server (port 8765 by default)
scripts/run_server_with_token.sh
```

### Access the Web UI

Open your browser to: `http://127.0.0.1:8765/mail`

### Manual Agent Integration

If you prefer manual integration, see the integration scripts:
- `scripts/integrate_codex_cli.sh` - For OpenAI Codex
- `scripts/integrate_claude_code.sh` - For Claude Code
- `scripts/integrate_gemini_cli.sh` - For Gemini CLI

## 🎯 Use Cases

### Multi-Repository Coordination
Work on frontend and backend simultaneously with agents that stay in sync:
```
Backend Agent (GreenCastle) ←→ Frontend Agent (BlueLake)
         ↓                              ↓
    Express.js API              React Components
         ↓                              ↓
    Shared message thread: "API Contract Changes"
```

### Conflict Prevention
Agents reserve files before editing:
```python
# Agent A reserves auth routes
reserve_file_paths(
    paths=["src/auth/**/*.py"],
    exclusive=True,
    ttl_seconds=3600
)

# Agent B's edit attempt is warned of conflict
```

### Context Maintenance
Search and summarize conversations:
```bash
# Find all messages about authentication
search_messages(query="auth AND security")

# Get summary of a feature thread
summarize_thread(thread_id="FEAT-123")
```

## 🔧 Configuration

Main config: `.env` (copy from `.env.example`)

Key environment variables:
- `STORAGE_ROOT`: Root directory for Git repos and SQLite DB
- `HTTP_HOST`: Bind host (default: `127.0.0.1`)
- `HTTP_PORT`: Bind port (default: `8765`)
- `HTTP_BEARER_TOKEN`: Optional authentication token
- `LLM_ENABLED`: Enable AI features for summaries and discovery

See `.env.example` for full configuration options.

## 📚 Documentation

**Complete Documentation Index**: [DOCUMENTATION.md](DOCUMENTATION.md)

Key guides:
- [Agent Onboarding Guide](docs/AGENT_ONBOARDING.md) - Get started with agents
- [Cross-Project Coordination](docs/CROSS_PROJECT_COORDINATION.md) - Multi-repo workflows
- [Integration Guide](INTEGRATION_GUIDE.md) - Complete setup walkthrough
- [Project Design Guide](docs/project_idea_and_guide.md) - Architecture deep-dive

## 🛠️ Development

### Run Tests
```bash
uv run pytest
```

### Lint and Format
```bash
uv run ruff check src/
uv run ruff format src/
```

### Start Development Server
```bash
uv run python -m mcp_agent_mail.cli serve-http
```

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│   Coding Agents (Codex, Claude, etc.)   │
└────────────────┬────────────────────────┘
                 │ HTTP (MCP Tools/Resources)
┌────────────────▼────────────────────────┐
│     Codex Mail MCP Server (FastMCP)     │
│  ┌────────────────┐  ┌────────────────┐ │
│  │  Web UI        │  │  MCP Endpoint  │ │
│  │  /mail/*       │  │  /mcp/         │ │
│  └────────────────┘  └────────────────┘ │
└────────┬────────────────────┬───────────┘
         │                    │
         ▼                    ▼
┌────────────────┐  ┌────────────────────┐
│   Git Storage  │  │   SQLite + FTS5    │
│  (Markdown)    │  │  (Metadata/Search) │
└────────────────┘  └────────────────────┘
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests and linting
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

This project builds upon:
- [FastMCP](https://github.com/jlowin/fastmcp) - MCP server framework
- [Model Context Protocol](https://modelcontextprotocol.io) - Open protocol for AI tool integration
- Original mcp_agent_mail by [Dicklesworthstone](https://github.com/Dicklesworthstone/mcp_agent_mail)

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/ApexHockey/codex_mail/issues)
- **Discussions**: [GitHub Discussions](https://github.com/ApexHockey/codex_mail/discussions)

---

**Built with ❤️ for the multi-agent future**
