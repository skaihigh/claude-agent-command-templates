# Claude Templates Architecture

## Overview

This repository implements a **single-point-of-change** system for managing Claude Code configurations across multiple projects using symlinks and layered configuration.

## Design Principles

### 1. Single Source of Truth
All universal agents, commands, and skills are stored in `.shared/` directory. Projects symlink to this directory, ensuring:
- One edit updates all projects instantly
- No manual syncing required
- Consistent capabilities across projects
- Easy version control and rollback

### 2. Layered Architecture
Configuration is composed in layers:

```
┌─────────────────────────────────────────┐
│  Project-Specific                       │
│  - instructions.md (context)            │
│  - settings.local.json (permissions)    │
├─────────────────────────────────────────┤
│  Template-Specific (if using template)  │
│  - specialized/agents/                  │
│  - specialized/commands/                │
│  - specialized/skills/                  │
├─────────────────────────────────────────┤
│  Shared/Universal (symlinked)           │
│  - .shared/agents/                      │
│  - .shared/commands/                    │
│  - .shared/skills/                      │
└─────────────────────────────────────────┘
```

### 3. Separation of Concerns

**Universal** (`.shared/`)
- Capabilities useful for ALL project types
- Language/framework agnostic
- General-purpose agents and commands

**Template-Specific** (`templates/*/specialized/`)
- Domain-specific agents (React, audio, PWA, etc.)
- Tech-stack-specific commands
- Project-type-specific skills

**Project-Specific** (`.claude/instructions.md`, `settings.local.json`)
- Project context and architecture
- Business logic and domain knowledge
- Custom permissions and settings

## Directory Structure

```
claude-templates/
├── .shared/                          # Single source of truth
│   ├── agents/                       # 5 universal agents
│   │   ├── codebase-analyzer.md
│   │   ├── codebase-locator.md
│   │   ├── codebase-pattern-finder.md
│   │   ├── test-engineer.md
│   │   └── web-search-researcher.md
│   ├── commands/                     # 7 universal commands
│   │   ├── commit.md
│   │   ├── create_handoff.md
│   │   ├── create_plan.md
│   │   ├── implement_plan.md
│   │   ├── research_codebase.md
│   │   ├── resume_handoff.md
│   │   └── validate_plan.md
│   ├── skills/                       # Universal skills
│   └── README.md                     # Documentation
│
├── templates/                        # Project type templates
│   ├── music-app/.claude/
│   │   ├── agents -> ../../../.shared/agents        # Symlink
│   │   ├── commands -> ../../../.shared/commands    # Symlink
│   │   ├── skills -> ../../../.shared/skills        # Symlink
│   │   ├── specialized/                             # Template-specific
│   │   │   ├── agents/
│   │   │   │   ├── audio-engineer.md
│   │   │   │   ├── accessibility-expert.md
│   │   │   │   ├── react-architect.md
│   │   │   │   └── pwa-specialist.md
│   │   │   ├── commands/
│   │   │   │   ├── audio-impl.md
│   │   │   │   ├── a11y-audit.md
│   │   │   │   └── pwa-check.md
│   │   │   └── skills/
│   │   │       ├── audio-debugging/
│   │   │       └── pwa-troubleshooting/
│   │   ├── README.md
│   │   ├── SECRETS-SETUP.md
│   │   └── settings.local.json.example
│   │
│   ├── react-pwa/.claude/            # Similar structure
│   ├── firebase-app/.claude/         # Similar structure
│   └── backend-api/.claude/          # Similar structure
│
├── scripts/
│   └── setup-claude.sh               # Automated project setup
│
├── docs/
│   ├── SETUP_GUIDE.md                # User documentation
│   └── ARCHITECTURE.md               # This file
│
└── README.md                         # Main documentation
```

## How Symlinks Work

### In Templates

Templates use **relative symlinks** to `.shared/`:

```bash
cd templates/music-app/.claude
ls -la

# agents -> ../../../.shared/agents
# commands -> ../../../.shared/commands
# skills -> ../../../.shared/skills
```

Relative path breakdown:
- `../` - Go up to `music-app/`
- `../../` - Go up to `templates/`
- `../../../` - Go up to `claude-templates/`
- `../../../.shared/agents` - Enter `.shared/agents/`

### In Projects

Projects use **absolute symlinks** to `.shared/`:

```bash
cd ~/projects/my-app/.claude
ls -la

# agents -> /Users/username/Documents/PRIVATE/claude-templates/.shared/agents
# commands -> /Users/username/Documents/PRIVATE/claude-templates/.shared/commands
# skills -> /Users/username/Documents/PRIVATE/claude-templates/.shared/skills
```

Absolute paths ensure symlinks work regardless of project location.

## Configuration Resolution

When Claude Code looks for an agent/command/skill:

1. **Check project directory** (`.claude/`)
   - If found, use it (allows project-specific overrides)

2. **Check symlinked directories** (`.claude/agents/`, etc.)
   - Follows symlink to `.shared/`
   - Returns universal agent/command/skill

3. **Check specialized directories** (`.claude/specialized/`)
   - If using a template, check template-specific additions
   - Provides domain-specific capabilities

Result: Projects see a **merged view** of all available capabilities.

## Data Flow

### When You Edit a Shared Agent

```
1. Edit: .shared/agents/codebase-analyzer.md
         ↓
2. Git:  git commit -am "improve: Better pattern detection"
         ↓
3. Propagation: ALL projects see change instantly (via symlinks)
         ↓
4. Projects:
   - project1/.claude/agents/codebase-analyzer.md (symlink)
   - project2/.claude/agents/codebase-analyzer.md (symlink)
   - project3/.claude/agents/codebase-analyzer.md (symlink)
   All point to the same file in .shared/
```

### When You Add a Universal Agent

```
1. Create: .shared/agents/new-agent.md
           ↓
2. Git:    git add .shared/agents/new-agent.md
           git commit -m "feat: Add new universal agent"
           ↓
3. Propagation: ALL projects see new agent (via symlinks)
           ↓
4. Projects: Can immediately use new agent
```

### When You Add a Template-Specific Agent

```
1. Create: templates/music-app/.claude/specialized/agents/audio-engineer.md
           ↓
2. Git:    git add templates/music-app/.claude/specialized/
           git commit -m "feat: Add audio-engineer to music-app template"
           ↓
3. Propagation: Only projects using music-app template get this agent
           ↓
4. Usage:  Include specialized/ directory when initializing from template
```

## Setup Script Flow

The `scripts/setup-claude.sh` script automates project initialization:

```
1. Parse arguments
   - PROJECT_PATH (required)
   - --template TEMPLATE (optional)
   - --shared-only (optional)
   ↓
2. Create/verify .claude directory
   ↓
3. Create symlinks to .shared/
   - agents -> .shared/agents
   - commands -> .shared/commands
   - skills -> .shared/skills
   ↓
4. If --template specified:
   - Copy specialized/ directory
   - Copy documentation (README, SECRETS-SETUP)
   - Copy settings.local.json.example
   ↓
5. Create instructions.md template if doesn't exist
   ↓
6. Create settings.local.json template if needed
   ↓
7. Display summary and next steps
```

## Benefits of This Architecture

### 1. Zero Duplication
- No need to copy agents/commands between projects
- Single file serves all projects via symlinks
- Changes propagate instantly

### 2. Version Control
- `.shared/` tracked in git
- Easy to see what changed and when
- Can rollback if needed
- Branch for experiments

### 3. Scalability
- Adding new project: One command (`setup-claude.sh`)
- Adding new agent: Create in `.shared/`, all projects see it
- Updating agent: Edit once, updates everywhere

### 4. Flexibility
- Universal capabilities via `.shared/`
- Template-specific additions via `specialized/`
- Project-specific overrides by creating local files
- Layered composition means no conflicts

### 5. Maintainability
- Clear separation of universal vs specialized
- Documentation co-located with code
- Easy to understand what's shared vs project-specific
- Setup script reduces manual work

## Git Strategy

### What's Tracked

**In claude-templates repo:**
```gitignore
.shared/                    # Tracked (universal config)
templates/                  # Tracked (templates)
scripts/                    # Tracked (automation)
docs/                       # Tracked (documentation)
README.md                   # Tracked (main docs)
.gitignore                  # Tracked (ignore rules)
```

**In project repos:**
```gitignore
.claude/agents              # Symlink (tracked as link)
.claude/commands            # Symlink (tracked as link)
.claude/skills              # Symlink (tracked as link)
.claude/instructions.md     # Tracked (project-specific)
.claude/settings.local.json # NOT tracked (secrets)
.claude/specialized/        # Tracked if copied from template
```

### Collaboration

Multiple developers can share:
1. **claude-templates repo** (via git)
2. **project repos** (with symlinks)

Setup for new developer:
```bash
# 1. Clone claude-templates
git clone <claude-templates-repo> ~/Documents/PRIVATE/claude-templates

# 2. Clone project
git clone <project-repo> ~/projects/my-project

# 3. Symlinks already configured (tracked in git)
cd ~/projects/my-project
ls -la .claude/  # Shows symlinks to claude-templates

# 4. Ready to use!
```

## Security Considerations

### What's Safe to Share (Public/Team)
- ✅ Agents (no secrets)
- ✅ Commands (no secrets)
- ✅ Skills (no secrets)
- ✅ instructions.md (project context)
- ✅ Symlinks (just pointers)

### What's Private (Never Commit)
- ❌ settings.local.json (permissions, may contain sensitive patterns)
- ❌ Any file with API keys/tokens
- ❌ *secrets*.json or *secrets*.env

### .gitignore Protection

**In claude-templates:**
```gitignore
# Never commit secrets
*secrets*.json
*secrets*.env
*api-keys*.json
.env
.env.local
```

**In projects:**
```gitignore
# Claude Code secrets
.claude/settings.local.json
.claude/**/*.local.md
.claude/.env

# MCP secrets
.mcp.local.json
*secrets*.json
*secrets*.env
```

## Performance Considerations

### Symlink Performance
- **No performance penalty**: Symlinks are filesystem pointers
- OS resolves symlinks transparently
- No duplicate storage (all projects share one file)

### Git Performance
- Symlinks tracked as small text files (path to target)
- No large file duplication in git history
- Fast clone/pull operations

### Claude Code Performance
- Claude Code reads files through symlinks normally
- No difference in loading time vs regular files
- Caching works as expected

## Future Enhancements

### 1. Nested Shared Directories
Organize `.shared/` by category:
```
.shared/
├── agents/
│   ├── analysis/
│   ├── testing/
│   └── research/
├── commands/
│   ├── planning/
│   ├── execution/
│   └── quality/
└── skills/
```

### 2. Version Tags
Tag releases for stability:
```bash
git tag v1.0.0
# Projects can pin to specific versions if needed
```

### 3. Remote Templates
Support templates from other repos:
```bash
setup-claude.sh . --template https://github.com/user/custom-template
```

### 4. Configuration Validation
Script to validate setup:
```bash
scripts/validate-setup.sh ~/projects/my-app
# Checks symlinks, permissions, required files
```

### 5. Update Notifications
Notify projects of upstream changes:
```bash
scripts/check-updates.sh
# Shows what's changed in .shared/ since last pull
```

## Troubleshooting

See [SETUP_GUIDE.md](SETUP_GUIDE.md#troubleshooting) for detailed troubleshooting steps.

## Summary

This architecture provides:
- ✅ **Single point of change** via `.shared/`
- ✅ **Zero duplication** via symlinks
- ✅ **Layered composition** for flexibility
- ✅ **Git-friendly** version control
- ✅ **Automated setup** via scripts
- ✅ **Template system** for specialization
- ✅ **Project isolation** for customization

The result is a maintainable, scalable, and efficient system for managing Claude Code configurations across unlimited projects.
