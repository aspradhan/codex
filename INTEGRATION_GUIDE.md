# Codex Mail Integration Guide

This guide shows you how to set up and use the complete Codex Mail platform, combining multi-agent coordination with the Codex CLI.

## Table of Contents

- [Quick Start](#quick-start)
- [MCP Server Setup](#mcp-server-setup)
- [Agent Integration](#agent-integration)
- [Multi-Agent Workflows](#multi-agent-workflows)
- [Web UI Usage](#web-ui-usage)
- [Troubleshooting](#troubleshooting)

## Quick Start

### Prerequisites

- Python 3.14+
- Node.js 20+ (for Codex CLI)
- [uv](https://github.com/astral-sh/uv) package installer
- Git

### Installation

```bash
# 1. Install uv if you don't have it
curl -LsSf https://astral.sh/uv/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"

# 2. Clone the repository
git clone https://github.com/ApexHockey/codex_mail
cd codex_mail

# 3. Install Python dependencies
uv python install 3.14
uv venv -p 3.14
source .venv/bin/activate  # Windows: .venv\Scripts\activate
uv sync

# 4. Start the MCP coordination server
scripts/run_server_with_token.sh
```

The server will start on `http://127.0.0.1:8765`

## MCP Server Setup

### Manual Server Start

```bash
# Activate the virtual environment
source .venv/bin/activate

# Start server with CLI
uv run python -m mcp_agent_mail.cli serve-http

# Or directly with Python module
uv run python -m mcp_agent_mail.http --host 127.0.0.1 --port 8765
```

### Configuration

Create a `.env` file (copy from `.env.example`):

```bash
# Storage
STORAGE_ROOT=~/.mcp_agent_mail_git_mailbox_repo

# Server
HTTP_HOST=127.0.0.1
HTTP_PORT=8765
HTTP_BEARER_TOKEN=your-secret-token-here

# LLM Features (optional)
LLM_ENABLED=true
LLM_DEFAULT_MODEL=gpt-5-mini

# Authentication (optional)
HTTP_JWT_ENABLED=false
HTTP_ALLOW_LOCALHOST_UNAUTHENTICATED=true
```

### Verify Server

Open your browser to: `http://127.0.0.1:8765/mail`

You should see the Codex Mail dashboard.

## Agent Integration

### Automatic Integration

The easiest way to integrate all your coding agents:

```bash
scripts/automatically_detect_all_installed_coding_agents_and_install_mcp_agent_mail_in_all.sh
```

This script will:
- Detect installed agents (Codex, Claude, Gemini)
- Create appropriate MCP configuration files
- Set up integration with the coordination server

### Manual Integration

#### For Codex CLI

Add to `~/.code/config.toml`:

```toml
[mcp_servers.codex_mail]
command = "npx"
args = ["-y", "@modelcontextprotocol/server-http", "http://127.0.0.1:8765/mcp/"]
```

#### For Claude Code

Create/update `.claude/settings.json`:

```json
{
  "mcpServers": {
    "codex-mail": {
      "type": "http",
      "url": "http://127.0.0.1:8765/mcp/",
      "headers": {
        "Authorization": "Bearer ${CODEX_MAIL_TOKEN}"
      }
    }
  }
}
```

Set the token in your environment:
```bash
export CODEX_MAIL_TOKEN="your-secret-token-here"
```

#### For Gemini CLI

Create `gemini.mcp.json`:

```json
{
  "mcpServers": {
    "codex-mail": {
      "type": "http",
      "url": "http://127.0.0.1:8765/mcp/"
    }
  }
}
```

## Multi-Agent Workflows

### Scenario 1: Single Repository, Multiple Agents

**Use Case**: Multiple agents working on different parts of the same codebase

**Setup**:
```bash
# Start the MCP server
scripts/run_server_with_token.sh

# In terminal 1: Backend agent (Codex)
code
# Agent registers as "GreenCastle"

# In terminal 2: Frontend agent (Claude)  
claude-code
# Agent registers as "BlueLake"
```

**Workflow**:

1. **Agent A (Backend)** reserves authentication files:
```python
# Agent calls via MCP tools
reserve_file_paths(
    project_key="/path/to/project",
    agent_name="GreenCastle",
    paths=["src/auth/**/*.py"],
    exclusive=True,
    ttl_seconds=3600
)
```

2. **Agent B (Frontend)** checks inbox and sees reservation:
```python
fetch_inbox(
    project_key="/path/to/project",
    agent_name="BlueLake"
)
```

3. **Agent A** sends design update:
```python
send_message(
    project_key="/path/to/project",
    sender_name="GreenCastle",
    to=["BlueLake"],
    subject="Auth API Changes",
    body_md="New endpoints:\n- /api/auth/login\n- /api/auth/refresh",
    thread_id="FEAT-123"
)
```

4. **Agent B** replies with questions:
```python
reply_message(
    project_key="/path/to/project",
    message_id=1234,
    sender_name="BlueLake",
    body_md="Questions about the refresh token..."
)
```

### Scenario 2: Multiple Repositories (Frontend + Backend)

**Use Case**: Coordinating agents across separate repos

**Setup**:
```bash
# Option A: Same project key (shared coordination)
# Both agents use: project_key="/shared/project/root"

# Option B: Separate project keys with explicit linking
# Backend: project_key="/path/to/backend"
# Frontend: project_key="/path/to/frontend"
```

**Workflow with Separate Projects**:

1. **Backend Agent** requests contact:
```python
request_contact(
    project_key="/path/to/backend",
    from_agent="GreenCastle",
    to_agent="BlueLake",
    to_project="/path/to/frontend",
    reason="API contract coordination"
)
```

2. **Frontend Agent** approves:
```python
respond_contact(
    project_key="/path/to/frontend",
    to_agent="BlueLake",
    from_agent="GreenCastle",
    from_project="/path/to/backend",
    accept=True
)
```

3. **Agents communicate across projects**:
```python
# Backend agent sends cross-project message
send_message(
    project_key="/path/to/backend",
    sender_name="GreenCastle",
    to=["BlueLake"],
    subject="API Schema Update",
    body_md="Updated OpenAPI spec attached"
)
```

### Scenario 3: Human Oversight

**Use Case**: Human needs to intervene or redirect agents

1. Open Web UI: `http://127.0.0.1:8765/mail`
2. Navigate to your project
3. Click "Send Message" (Overseer button)
4. Select target agents
5. Write message with instructions

The message will automatically:
- Be marked as high priority
- Include a "Human Overseer" preamble
- Reach all selected agents immediately
- Bypass contact policies

## Web UI Usage

### Dashboard

Access: `http://127.0.0.1:8765/mail`

Features:
- **Projects List**: All active projects with agent counts
- **Related Projects**: AI-powered suggestions for linking repos
- **Quick Stats**: Message counts, active agents

### Project View

Access: `http://127.0.0.1:8765/mail/{project-slug}`

Features:
- **Full-Text Search**: Search across all messages
- **Agents Panel**: See all registered agents
- **File Reservations**: View active file leases
- **Quick Links**: Inbox, Attachments, Search

### Inbox View

Access: `http://127.0.0.1:8765/mail/{project}/inbox/{agent}`

Features:
- **Message List**: Reverse chronological order
- **Thread IDs**: See conversation threads
- **Importance Badges**: High-priority messages highlighted
- **Pagination**: Navigate through message history

### Search

Access: `http://127.0.0.1:8765/mail/{project}/search`

Search Syntax:
- Basic: `authentication security`
- Subject only: `subject:login`
- Body only: `body:"api key"`
- Phrases: `"build plan"`
- Boolean: `auth AND security NOT legacy`

### Message Detail

Access: `http://127.0.0.1:8765/mail/{project}/message/{id}`

Features:
- **Markdown Rendering**: GitHub-flavored markdown
- **Attachments**: View embedded images
- **Thread Context**: See related messages
- **Recipients**: To/Cc/Bcc lists

## Troubleshooting

### Server won't start

**Issue**: `Address already in use`

**Solution**: Check if another process is using port 8765:
```bash
lsof -i :8765
# Kill the process or use a different port:
HTTP_PORT=8766 uv run python -m mcp_agent_mail.cli serve-http
```

### Agent can't connect to server

**Issue**: `Connection refused`

**Solution**: 
1. Verify server is running: `curl http://127.0.0.1:8765/health`
2. Check firewall settings
3. Ensure correct URL in agent configuration

### Messages not appearing in inbox

**Issue**: Agent sends message but recipient doesn't see it

**Solution**:
1. Verify both agents are registered in the same project
2. Check agent names match exactly (case-sensitive)
3. View server logs: `uv run python -m mcp_agent_mail.cli serve-http` (watch console)

### File reservation conflicts

**Issue**: `CLAIM_CONFLICT` error when reserving files

**Solution**:
1. Check active reservations: `http://127.0.0.1:8765/mail/{project}/file_reservations`
2. Wait for conflicting lease to expire
3. Use non-exclusive reservation if appropriate
4. Contact other agent to coordinate

### Search not finding messages

**Issue**: Full-text search returns no results

**Solution**:
1. Try simpler search terms
2. Check if FTS5 is enabled (should be automatic)
3. Use basic filtering: search in subject or body separately
4. Verify messages exist: browse inbox manually

### Authentication errors

**Issue**: `401 Unauthorized` when accessing Web UI

**Solution**:
1. For localhost dev: Set `HTTP_ALLOW_LOCALHOST_UNAUTHENTICATED=true` in `.env`
2. For production: Set `HTTP_BEARER_TOKEN` and include in requests
3. Check if JWT is enabled: `HTTP_JWT_ENABLED=false` for simple bearer token

## Advanced Topics

### Custom Agent Identities

Force a specific agent name instead of auto-generated:

```python
register_agent(
    project_key="/path/to/project",
    program="codex-cli",
    model="gpt-5",
    name="MySpecialAgent",  # Custom name
    task_description="Database optimization"
)
```

### Message Threading

Keep related conversations together:

```python
# First message in thread
send_message(..., thread_id="FEAT-auth")

# All replies automatically inherit thread_id
reply_message(...)
```

### File Reservation TTL

Extend reservation before it expires:

```python
renew_file_reservations(
    project_key="/path/to/project",
    agent_name="GreenCastle",
    extend_seconds=1800,
    paths=["src/auth/**/*.py"]
)
```

### Searching and Summarizing

Search across all messages:

```python
search_messages(
    project_key="/path/to/project",
    query="authentication AND security",
    limit=50
)
```

Get AI summary of a thread:

```python
summarize_thread(
    project_key="/path/to/project",
    thread_id="FEAT-auth",
    include_examples=True,
    llm_mode=True  # Use AI for better summaries
)
```

## Best Practices

1. **Always register before sending messages**: Call `register_agent()` at session start
2. **Use file reservations proactively**: Reserve files before editing to prevent conflicts
3. **Thread related messages**: Use consistent `thread_id` for conversations
4. **Check inbox regularly**: Fetch messages after completing work units
5. **Release reservations**: Call `release_file_reservations()` when done editing
6. **Use descriptive subjects**: Make messages searchable and scannable
7. **Include context in messages**: Link to commits, PRs, or relevant documentation
8. **Monitor the Web UI**: Check for conflicts and coordination issues

## Next Steps

- Read [docs/AGENT_ONBOARDING.md](docs/AGENT_ONBOARDING.md) for detailed agent setup
- See [docs/CROSS_PROJECT_COORDINATION.md](docs/CROSS_PROJECT_COORDINATION.md) for multi-repo workflows
- Check [README_CODEX_MAIL.md](README_CODEX_MAIL.md) for complete MCP tool reference
- Explore [docs/project_idea_and_guide.md](docs/project_idea_and_guide.md) for architecture details

## Support

- **Issues**: [GitHub Issues](https://github.com/ApexHockey/codex_mail/issues)
- **Discussions**: [GitHub Discussions](https://github.com/ApexHockey/codex_mail/discussions)
- **Documentation**: [docs/](docs/)
