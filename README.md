# Claude Code Template Library

A **single-point-of-change** system for managing Claude Code configurations across all your projects. Edit once, update everywhere.

## 🎯 Key Features

- **Shared Configuration** - Universal agents, commands, and skills synced via symlinks
- **Single Point of Change** - Edit `.shared/` once, all projects update instantly
- **Template-Based** - Project-type templates with specialized capabilities
- **Automated Setup** - One-command initialization for new projects
- **Git-Friendly** - Version controlled, collaborative, with proper .gitignore patterns

## 🚀 Quick Start

### New Project

```bash
# Initialize with shared configuration only
~/Documents/PRIVATE/claude-templates/scripts/setup-claude.sh ~/path/to/project

# Or with a template
~/Documents/PRIVATE/claude-templates/scripts/setup-claude.sh ~/path/to/project --template react-pwa
```

### Existing Project

```bash
cd your-project
~/Documents/PRIVATE/claude-templates/scripts/setup-claude.sh .
```

**Result:** Your project now has access to all shared agents and commands, plus any template-specific additions.

## 📚 Documentation

- **[Setup Guide](docs/SETUP_GUIDE.md)** - Detailed setup and usage instructions
- **[Shared Config](/.shared/README.md)** - Universal agents and commands reference
- **Templates** - See individual template directories for specialized capabilities

## Architecture Overview

```
claude-templates/
├── .shared/              # ⭐ SINGLE SOURCE OF TRUTH
│   ├── agents/          # Universal agents (5 agents)
│   ├── commands/        # Universal commands (7 commands)
│   └── skills/          # Universal skills
├── templates/           # Project type templates
│   ├── music-app/
│   ├── react-pwa/
│   ├── firebase-app/
│   └── backend-api/
└── scripts/
    └── setup-claude.sh  # Automated setup script
```

### How It Works

Each project's `.claude/` directory contains:
- **Symlinks** to `.shared/agents/`, `.shared/commands/`, `.shared/skills/`
- **Project-specific files** (instructions.md, settings.local.json)
- **Template-specific files** (if using a template)

**Benefits:**
- Edit a shared agent once → All projects see the change
- No manual copying or syncing needed
- Consistent capabilities across all projects
- Easy to maintain and update

## Available Templates

### 1. Music App (PWA)
**Path**: `templates/music-app/`

Progressive Web App for music practice with audio playback, pitch preservation, loop controls, and Firebase backend. Optimized for young musicians (age 10+).

**Tech Stack**: React 18, TypeScript, Vite, TailwindCSS, shadcn/ui, Firebase, Web Audio API, Tone.js, Workbox

**Specialized Agents**:
- audio-engineer
- pwa-specialist
- react-architect
- accessibility-expert
- test-engineer
- codebase-analyzer
- codebase-locator

**Best For**: Music education apps, audio practice tools, PWAs with complex audio requirements

---

### 2. React PWA
**Path**: `templates/react-pwa/`

Minimal Progressive Web App with React, TypeScript, and offline-first architecture. Optimized for performance and mobile experience.

**Tech Stack**: React 18, TypeScript, Vite, TailwindCSS, Workbox, IndexedDB

**Specialized Agents**:
- pwa-specialist
- react-architect
- test-engineer

**Best For**: Offline-first web apps, mobile-optimized SPAs, installable web apps

---

### 3. Firebase Full-Stack App
**Path**: `templates/firebase-app/`

Full-stack application with React frontend and Firebase backend (Auth, Firestore, Storage, Functions). Multi-tenant ready.

**Tech Stack**: React 18, TypeScript, Firebase (Auth, Firestore, Storage, Functions), TailwindCSS

**Specialized Agents**:
- react-architect
- test-engineer
- codebase-analyzer

**Best For**: SaaS applications, multi-tenant apps, real-time collaborative tools

---

### 4. Backend API
**Path**: `templates/backend-api/`

RESTful API backend with Node.js, TypeScript, and Express. Includes authentication, database integration, and API documentation.

**Tech Stack**: Node.js, TypeScript, Express, Prisma, PostgreSQL, JWT, OpenAPI/Swagger

**Specialized Agents**:
- test-engineer
- codebase-analyzer

**Best For**: REST APIs, microservices, backend services

---

## 📖 Universal Configuration (Always Available)

All projects with symlinks to `.shared/` get these capabilities:

### Universal Agents
- **codebase-analyzer** - Analyzes implementation details
- **codebase-locator** - Finds files and components
- **codebase-pattern-finder** - Discovers patterns and examples
- **test-engineer** - Testing specialist
- **web-search-researcher** - Web research and information gathering

### Universal Commands
- **/commit** - Create git commits with proper workflow
- **/create_plan** - Create detailed implementation plans
- **/implement_plan** - Implement plans with verification
- **/validate_plan** - Validate implementations against plans
- **/create_handoff** - Create handoff documents
- **/resume_handoff** - Resume from handoff documents
- **/research_codebase** - Document codebase comprehensively

## 🎨 Working with Shared Configuration

### Adding Universal Content

To add an agent/command that ALL projects should have:

```bash
cd ~/Documents/PRIVATE/claude-templates/.shared/agents
nano my-new-agent.md
git commit -am "feat: Add new universal agent"
git push
```

**Result:** All projects see the new agent immediately via symlinks.

### Updating Shared Content

```bash
cd ~/Documents/PRIVATE/claude-templates/.shared/agents
nano codebase-analyzer.md  # Make improvements
git commit -am "improve: Better pattern detection"
git push
```

**Result:** All projects get the update instantly.

---

## Template Structure

Each template contains:

```
template-name/
├── .claude/
│   ├── README.md              # Template documentation
│   ├── agents/                # Specialized AI agents
│   │   ├── agent1.md
│   │   └── agent2.md
│   ├── commands/              # Slash commands
│   │   ├── command1.md
│   │   └── command2.md
│   └── skills/                # Skill modules
│       └── skill1/
└── template.json              # Template metadata
```

### template.json

Each template includes a `template.json` file with:
- Template name and description
- Tech stack details
- Required and optional MCP servers
- Specialized agents list
- Slash commands list
- Skills list
- Project structure overview
- Setup instructions
- Recommended .gitignore additions
- Usage notes

---

## MCP Server Configuration

### Global MCP Secrets

All API keys are stored in `~/.config/claude-mcp/mcp-secrets.env`:

```bash
# Example secrets file
FIGMA_PERSONAL_ACCESS_TOKEN=your-token-here
CONTEXT7_API_KEY=your-key-here
BRIGHTDATA_API_KEY=your-key-here
TAVILY_API_KEY=your-key-here
MEMORY_BANK_ROOT=/path/to/your/memory-bank
```

This file is:
- Loaded automatically via `~/.zshrc`
- Protected with `chmod 600` (owner read/write only)
- Never committed to git
- Shared across all projects

### VS Code MCP Configuration

MCP servers are configured in `~/Library/Application Support/Code/User/mcp.json` using environment variable references:

```json
{
  "servers": {
    "firebase": {
      "command": "npx",
      "args": ["-y", "firebase-tools@latest", "mcp"],
      "type": "stdio"
    },
    "tavily-mcp": {
      "command": "npx",
      "args": ["-y", "tavily-mcp@latest"],
      "env": {
        "TAVILY_API_KEY": "${TAVILY_API_KEY}"
      },
      "type": "stdio"
    }
  }
}
```

---

## Customizing Templates

### Adding a New Agent

1. Create a new markdown file in `.claude/agents/`:

```bash
touch .claude/agents/my-specialist.md
```

2. Define the agent's expertise:

```markdown
# My Specialist Agent

You are an expert in [domain], specializing in:

## Core Expertise
- Area 1
- Area 2

## Best Practices
- Practice 1
- Practice 2
```

### Adding a New Slash Command

1. Create a new markdown file in `.claude/commands/`:

```bash
touch .claude/commands/my-command.md
```

2. Define the command behavior:

```markdown
# My Command

When the user runs /my-command, perform the following tasks:

1. Step 1
2. Step 2
3. Step 3
```

### Creating a New Template

1. Create template directory:

```bash
mkdir -p templates/my-template/.claude/{agents,commands,skills}
```

2. Create `template.json` with metadata
3. Add specialized agents to `.claude/agents/`
4. Add slash commands to `.claude/commands/`
5. Create `.claude/README.md` documentation

---

## Security Best Practices

### What to Commit
✅ `.claude/` directory and all configuration files
✅ `template.json` metadata
✅ Agent definitions
✅ Command definitions
✅ Skill modules
✅ Documentation

### What to NEVER Commit
❌ `.claude/settings.local.json` (project-specific secrets)
❌ API keys or tokens in any form
❌ `*secrets*.json` or `*secrets*.env`
❌ `*api-keys*.json`

### .gitignore Protection

Always include these patterns in your project `.gitignore`:

```gitignore
# Claude Code configuration secrets (NEVER commit)
.claude/settings.local.json
.claude/**/*.local.md
.claude/.env
.mcp.local.json
*secrets*.json
*secrets*.env
*api-keys*.json
```

---

## Template Usage Workflow

### Day-to-Day Development

1. **Start project**: Open in VS Code with Claude Code
2. **Use specialized agents**: Invoke via Task tool or agent name
3. **Run slash commands**: Type `/command-name` in Claude Code
4. **Leverage skills**: Auto-invoked or manually triggered

### Adding Project-Specific Configuration

1. Create `.claude/settings.local.json` (git-ignored)
2. Add project-specific overrides
3. Document in project README

### Syncing Template Updates

```bash
# Pull latest templates
cd ~/Documents/PRIVATE/claude-templates
git pull origin main

# Manually copy updated files to your project
cp templates/react-pwa/.claude/agents/new-agent.md /path/to/project/.claude/agents/
```

---

## Maintenance

### Updating Templates

1. Make changes to template in `~/Documents/PRIVATE/claude-templates/`
2. Test in a sample project
3. Commit and push to private GitHub repo
4. Pull updates in other environments

### Version Control

This template library is version-controlled in a private GitHub repository:

```bash
# Initialize git (if not already done)
cd ~/Documents/PRIVATE/claude-templates
git init
git add .
git commit -m "Initial commit"

# Create private GitHub repo
gh repo create claude-templates --private --source=. --push
```

### Backup

Templates are backed up to:
- Private GitHub repository
- Local `~/Documents/PRIVATE/claude-templates/`

---

## Troubleshooting

### Templates Not Loading

1. Verify `.claude/` directory exists in project root
2. Check file permissions
3. Restart VS Code
4. Check Claude Code output panel for errors

### MCP Servers Not Working

1. Verify global secrets file exists: `~/.config/claude-mcp/mcp-secrets.env`
2. Check environment variables are loaded: `echo $TAVILY_API_KEY`
3. Restart terminal to reload `~/.zshrc`
4. Verify VS Code mcp.json uses `${ENV_VAR}` syntax

### Agent or Command Not Found

1. Check file exists in `.claude/agents/` or `.claude/commands/`
2. Verify markdown formatting is correct
3. Check file has `.md` extension
4. Reload VS Code window

---

## Contributing

To add a new template or improve existing ones:

1. Create/modify template in local directory
2. Test thoroughly in a real project
3. Update `template.json` metadata
4. Update this README
5. Commit and push to GitHub

---

## License

Private use only. Not for public distribution.

---

## Changelog

### 2025-11-17 - Phase 2 Complete
- Created template library structure
- Added 4 base templates (music-app, react-pwa, firebase-app, backend-api)
- Created template.json metadata for each template
- Added specialized agents and commands
- Documented usage and setup

---

## Next Steps (Future Phases)

- **Phase 3**: Project-level security configuration templates
- **Phase 4**: Automated initialization script with `claude-init` command
- **Phase 5**: Template standardization and validation
- **Phase 6**: Advanced usage workflows and best practices

---

For questions or issues, refer to `docs/PORTABLE-CLAUDE-SETUP.md` in the VSSK-shadecn project.
