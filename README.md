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

---

## 📦 Installation & Setup Options

You can integrate this template library into your projects using three different methods. Choose based on your needs:

### Option 1: Symlinks (Recommended)

**Best for:** Active development where you want instant updates across all projects.

**Pros:**
- ✅ Edit once in `.shared/`, all projects update instantly
- ✅ No git submodule complexity
- ✅ Zero overhead - symlinks are instantaneous
- ✅ Easy to manage and understand

**Cons:**
- ❌ Symlinks don't work well across different machines/file systems
- ❌ Must have template library cloned locally

**Setup:**

```bash
# 1. Clone the template library (one-time setup)
git clone git@github.com:your-username/claude-templates.git ~/Documents/PRIVATE/claude-templates

# 2. Navigate to your project
cd ~/path/to/your-project

# 3. Create .claude directory if it doesn't exist
mkdir -p .claude

# 4. Create symlinks to shared configuration
cd .claude
ln -s ~/Documents/PRIVATE/claude-templates/.shared/agents agents
ln -s ~/Documents/PRIVATE/claude-templates/.shared/commands commands
ln -s ~/Documents/PRIVATE/claude-templates/.shared/skills skills

# 5. Create project-specific files
touch instructions.md
echo '{}' > settings.local.json

# 6. Update .gitignore
cat >> ../.gitignore << 'EOF'
# Claude Code secrets (NEVER commit)
.claude/settings.local.json
.claude/**/*.local.md
.claude/.env
EOF
```

**Verification:**
```bash
# Check symlinks are working
ls -la .claude/
# You should see agents, commands, skills as symbolic links
```

---

### Option 2: Git Submodule

**Best for:** Teams that want version-controlled shared configuration with explicit update control.

**Pros:**
- ✅ Works across different machines and operating systems
- ✅ Version controlled - pin to specific commits
- ✅ Explicit updates via `git submodule update`
- ✅ Works well in CI/CD pipelines

**Cons:**
- ❌ More complex to manage than symlinks
- ❌ Updates require explicit `git submodule update` command
- ❌ Learning curve for team members unfamiliar with submodules

**Setup:**

```bash
# 1. Navigate to your project
cd ~/path/to/your-project

# 2. Add claude-templates as a submodule
git submodule add git@github.com:your-username/claude-templates.git .claude-templates

# 3. Create .claude directory structure
mkdir -p .claude

# 4. Create symlinks to submodule's shared config
cd .claude
ln -s ../.claude-templates/.shared/agents agents
ln -s ../.claude-templates/.shared/commands commands
ln -s ../.claude-templates/.shared/skills skills

# 5. Create project-specific files
touch instructions.md
echo '{}' > settings.local.json

# 6. Commit the submodule
cd ..
git add .gitmodules .claude-templates .claude/
git commit -m "Add Claude Code templates as submodule"

# 7. Update .gitignore
cat >> .gitignore << 'EOF'
# Claude Code secrets (NEVER commit)
.claude/settings.local.json
.claude/**/*.local.md
.claude/.env
EOF
```

**Updating to Latest:**
```bash
# Pull latest changes from template library
cd .claude-templates
git pull origin main
cd ..
git add .claude-templates
git commit -m "Update Claude templates to latest"
```

**For Team Members Cloning:**
```bash
# Clone project with submodules
git clone --recurse-submodules git@github.com:your-username/your-project.git

# Or if already cloned without submodules
git submodule init
git submodule update
```

---

### Option 3: Direct Copy (One-Time Setup)

**Best for:** Projects that need customized templates or don't want external dependencies.

**Pros:**
- ✅ Complete independence - no external dependencies
- ✅ Full customization without affecting other projects
- ✅ Simple - just files in your repo
- ✅ Works everywhere without special setup

**Cons:**
- ❌ No automatic updates - must manually sync changes
- ❌ Duplication across projects
- ❌ Can drift from template library over time

**Setup:**

```bash
# 1. Clone the template library temporarily
git clone git@github.com:your-username/claude-templates.git /tmp/claude-templates

# 2. Navigate to your project
cd ~/path/to/your-project

# 3. Copy shared configuration
mkdir -p .claude
cp -r /tmp/claude-templates/.shared/agents .claude/agents
cp -r /tmp/claude-templates/.shared/commands .claude/commands
cp -r /tmp/claude-templates/.shared/skills .claude/skills

# 4. (Optional) Copy a template's specialized config
cp -r /tmp/claude-templates/templates/react-pwa/.claude/* .claude/

# 5. Create project-specific files
touch .claude/instructions.md
echo '{}' > .claude/settings.local.json

# 6. Clean up
rm -rf /tmp/claude-templates

# 7. Commit to your project
git add .claude/
git commit -m "Add Claude Code configuration"

# 8. Update .gitignore
cat >> .gitignore << 'EOF'
# Claude Code secrets (NEVER commit)
.claude/settings.local.json
.claude/**/*.local.md
.claude/.env
EOF
```

**Updating:**
```bash
# Manually pull changes and copy updated files
cd /tmp
git clone git@github.com:your-username/claude-templates.git
cp -r claude-templates/.shared/* ~/path/to/your-project/.claude/
rm -rf claude-templates
```

---

## 🔄 Comparison Matrix

| Feature | Symlinks | Submodule | Direct Copy |
|---------|----------|-----------|-------------|
| **Instant Updates** | ✅ Yes | ❌ No (manual) | ❌ No (manual) |
| **Cross-Machine** | ❌ No | ✅ Yes | ✅ Yes |
| **Version Control** | Shared | ✅ Yes | ✅ Yes |
| **Customization** | ❌ Limited | ❌ Limited | ✅ Full |
| **Team Friendly** | ⚠️ Depends | ✅ Yes | ✅ Yes |
| **CI/CD Compatible** | ❌ No | ✅ Yes | ✅ Yes |
| **Complexity** | Low | Medium | Low |
| **Best For** | Solo dev, local | Teams, production | Forking/custom |

---

## 🎯 Recommended Setup by Use Case

**Solo Developer (Single Machine):**
→ **Use Symlinks** - Simplest, instant updates

**Team Development:**
→ **Use Git Submodule** - Version controlled, works everywhere

**Forking/Customization:**
→ **Use Direct Copy** - Full control, no dependencies

**CI/CD Pipeline:**
→ **Use Git Submodule** or **Direct Copy** - Both work in automation

## 📚 Documentation

- **[Quick Usage Guide](USAGE_GUIDE.md)** ⭐ START HERE - "I want to..." quick reference table
- **[Agents & Commands Reference](AGENTS_COMMANDS_REFERENCE.md)** - Comprehensive guide to all agents, commands, and skills
- **[Cross-Platform Usage](CROSS_PLATFORM_USAGE.md)** - How to use with GitHub Copilot, Cursor, Windsurf, Codeium
- **[Known Issues](KNOWN_ISSUES.md)** ⚠️ IMPORTANT - Project-specific references that need adaptation
- **[Setup Guide](docs/SETUP_GUIDE.md)** - Detailed setup and usage instructions (if exists)
- **[Shared Config](/.shared/README.md)** - Universal agents and commands reference
- **Templates** - See individual template directories for specialized capabilities

---

## ⚠️ Important Notice

**Some agents and commands contain project-specific references** to the VSSK-shadecn music practice application. Before sharing with colleagues or using in other projects:

1. **Read [KNOWN_ISSUES.md](KNOWN_ISSUES.md)** for complete list of issues
2. **Use [USAGE_GUIDE.md](USAGE_GUIDE.md)** to identify which agents/commands work for your project type
3. **Adapt or avoid** files marked with 🔴 CRITICAL issues

**Quick Status:**
- ✅ **Clean & Ready**: 5 agents, 1 command
- ⚠️ **Needs Adaptation**: 7 agents, 18 commands
- 🔴 **Critical Issues**: Files referencing "VSSK-shadecn", audio app features, or hardcoded values

See [KNOWN_ISSUES.md](KNOWN_ISSUES.md) for detailed breakdown and fixes.

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
