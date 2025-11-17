# Claude Templates Setup Guide

This guide explains how to use the shared Claude configuration system across your projects.

## Overview

The claude-templates repository provides a **single-point-of-change** system for managing Claude Code agents, commands, and skills across multiple projects.

### Architecture

```
claude-templates/
├── .shared/              # ⭐ SINGLE SOURCE OF TRUTH
│   ├── agents/          # Universal agents (all projects)
│   ├── commands/        # Universal commands (all projects)
│   └── skills/          # Universal skills (all projects)
├── templates/           # Project type templates
│   ├── music-app/
│   ├── react-pwa/
│   ├── firebase-app/
│   └── backend-api/
└── scripts/
    └── setup-claude.sh  # Automated setup script
```

### How It Works

**Symlinks for Sharing:**
- Each project's `.claude/agents/`, `.claude/commands/`, and `.claude/skills/` are symlinks to `.shared/`
- Edit once in `.shared/` → changes apply to ALL projects instantly
- No manual copying, no version drift

**Layered Configuration:**
1. **Shared** (`.shared/`) - Universal capabilities
2. **Specialized** (`templates/*/specialized/`) - Template-specific additions
3. **Project-specific** (`.claude/instructions.md`) - Project context

## Quick Start

### For New Projects

Use the automated setup script:

```bash
cd ~/Documents/PRIVATE/claude-templates
./scripts/setup-claude.sh ~/path/to/your/project
```

With a template:
```bash
./scripts/setup-claude.sh ~/path/to/your/project --template react-pwa
```

Shared configuration only:
```bash
./scripts/setup-claude.sh ~/path/to/your/project --shared-only
```

### For Existing Projects

1. **Backup your current `.claude/` directory:**
   ```bash
   cp -r .claude .claude.backup
   ```

2. **Run the setup script:**
   ```bash
   ~/Documents/PRIVATE/claude-templates/scripts/setup-claude.sh .
   ```

3. **Restore project-specific files:**
   ```bash
   cp .claude.backup/instructions.md .claude/
   cp .claude.backup/settings.local.json .claude/
   ```

### Manual Setup

If you prefer manual setup:

```bash
cd your-project/.claude

# Remove existing directories
rm -rf agents commands skills

# Create symlinks
ln -s ~/Documents/PRIVATE/claude-templates/.shared/agents agents
ln -s ~/Documents/PRIVATE/claude-templates/.shared/commands commands
ln -s ~/Documents/PRIVATE/claude-templates/.shared/skills skills

# Keep project-specific files
# - instructions.md (your project context)
# - settings.local.json (your permissions)
```

## Available Templates

### music-app
**Specialized for:** Music/audio applications with PWA features

**Includes:**
- Agents: audio-engineer, accessibility-expert, pwa-specialist, react-architect
- Commands: audio-impl, a11y-audit, pwa-check, new-component
- Skills: audio-debugging, pwa-troubleshooting

### react-pwa
**Specialized for:** React Progressive Web Apps

**Includes:**
- Agents: react-architect, pwa-specialist
- Commands: new-component, pwa-check, test-coverage

### firebase-app
**Specialized for:** Firebase-powered applications

**Includes:**
- Agents: react-architect
- Commands: new-component, test-coverage

### backend-api
**Specialized for:** Backend API services

**Includes:**
- Commands: test-coverage

## Shared Configuration (Always Available)

### Universal Agents

All projects get these agents via `.shared/agents/`:

- **codebase-analyzer** - Analyzes implementation details
- **codebase-locator** - Finds files and components
- **codebase-pattern-finder** - Discovers patterns and examples
- **test-engineer** - Testing specialist
- **web-search-researcher** - Web research and information gathering

### Universal Commands

All projects get these commands via `.shared/commands/`:

- **/commit** - Create git commits with proper workflow
- **/create_plan** - Create detailed implementation plans
- **/implement_plan** - Implement plans with verification
- **/validate_plan** - Validate implementations against plans
- **/create_handoff** - Create handoff documents
- **/resume_handoff** - Resume from handoff documents
- **/research_codebase** - Document codebase comprehensively

## Managing Shared Configuration

### Adding New Universal Content

To add an agent/command/skill that ALL projects should have:

```bash
cd ~/Documents/PRIVATE/claude-templates/.shared

# Add new agent
nano agents/my-new-agent.md

# Add new command
nano commands/my-new-command.md

# Commit to git
git add .
git commit -m "feat: Add new universal agent/command"
git push
```

**Result:** All projects with symlinks instantly see the new content.

### Updating Shared Content

Edit directly in `.shared/`:

```bash
cd ~/Documents/PRIVATE/claude-templates/.shared/agents
nano codebase-analyzer.md  # Make your changes
git commit -am "fix: Improve codebase analyzer prompts"
git push
```

**Result:** All projects get the update immediately.

### Adding Template-Specific Content

For content that only certain project types need:

```bash
cd ~/Documents/PRIVATE/claude-templates/templates/react-pwa/.claude/specialized

# Add to specialized agents
nano agents/my-react-specialist.md

# Or specialized commands
nano commands/my-react-command.md
```

Projects using this template will get these additions.

## Project-Specific Configuration

Each project keeps its own:

### instructions.md
Project-specific context and guidelines:
- Project overview
- Architecture documentation
- Domain-specific rules
- Common pitfalls

**Example:**
```markdown
# Claude Instructions for This Project

## Project Overview
This is an OMR (Optical Music Recognition) system...

## Quick Reference
- **Piano scores** → Use oemer with `--without-deskew`
- **Orchestral scores** → Use Audiveris REST API
```

### settings.local.json
Project-specific permissions:
```json
{
  "permissions": {
    "allow": [
      "Bash(python3:*)",
      "Bash(docker:*)",
      "Bash(git add:*)"
    ],
    "deny": [],
    "ask": []
  }
}
```

## Workflow Examples

### Starting a New React PWA

```bash
# 1. Create project and initialize with template
~/claude-templates/scripts/setup-claude.sh ~/projects/my-pwa --template react-pwa

# 2. Customize for your project
cd ~/projects/my-pwa/.claude
nano instructions.md  # Add your project context

# 3. Start coding with Claude
# All shared commands and agents are ready to use
# Plus React/PWA-specific capabilities from the template
```

### Converting an Existing Project

```bash
# 1. Backup current config
cd ~/projects/existing-project
cp -r .claude .claude.backup

# 2. Setup shared configuration
~/claude-templates/scripts/setup-claude.sh .

# 3. Restore your project-specific files
cp .claude.backup/instructions.md .claude/
cp .claude.backup/settings.local.json .claude/

# 4. Verify everything works
ls -la .claude/
```

### Syncing Multiple Projects

When you improve a shared agent or command:

```bash
# 1. Edit in .shared/
cd ~/claude-templates/.shared/agents
nano codebase-analyzer.md

# 2. Commit
git commit -am "improve: Better pattern detection in codebase-analyzer"
git push

# 3. All projects are automatically updated!
# No need to manually sync anything
```

## Troubleshooting

### Symlinks Not Working

**Symptom:** Can't see agents/commands in Claude Code

**Solution:** Verify symlinks are correct:
```bash
cd your-project/.claude
ls -la

# Should show:
# agents -> /path/to/claude-templates/.shared/agents
# commands -> /path/to/claude-templates/.shared/commands
# skills -> /path/to/claude-templates/.shared/skills
```

Re-create if needed:
```bash
rm agents commands skills
ln -s ~/Documents/PRIVATE/claude-templates/.shared/agents agents
ln -s ~/Documents/PRIVATE/claude-templates/.shared/commands commands
ln -s ~/Documents/PRIVATE/claude-templates/.shared/skills skills
```

### Permission Issues

**Symptom:** Can't execute commands

**Solution:** Check and fix permissions:
```bash
chmod -R u+rw ~/Documents/PRIVATE/claude-templates/.shared
```

### Changes Not Appearing

**Symptom:** Edited a shared file but projects don't see changes

**Check:**
1. Did you edit in `.shared/` or in a project directory?
   - ✅ Edit in `.shared/`
   - ❌ Don't edit in project (it's a symlink)

2. Are symlinks pointing to the right place?
   ```bash
   ls -la .claude/agents
   ```

### Git Tracking Issues

**Symptom:** Git shows symlinks as modified

**Solution:** Symlinks should be committed to git:
```bash
git add .claude/agents .claude/commands .claude/skills
git commit -m "chore: Link to shared Claude configuration"
```

The symlink itself is tracked, not the contents.

## Best Practices

### 1. Keep Universal Content Universal
Only add to `.shared/` if ALL projects benefit:
- ✅ codebase-analyzer (every project has code)
- ✅ commit command (every project uses git)
- ❌ audio-engineer (only music projects need this)

### 2. Use Templates for Domain-Specific Content
Create specialized content in template directories:
- `templates/music-app/specialized/` for music-specific
- `templates/react-pwa/specialized/` for React/PWA-specific

### 3. Keep Project Context in instructions.md
Don't clutter shared agents with project-specific info:
- ✅ Project architecture → `instructions.md`
- ✅ Domain rules → `instructions.md`
- ❌ Project-specific prompts → Don't add to shared agents

### 4. Version Control Everything
Commit changes to `.shared/` for tracking:
```bash
cd ~/Documents/PRIVATE/claude-templates
git add .shared/
git commit -m "feat: Improve web-search-researcher agent"
git push
```

### 5. Document Your Changes
When adding/modifying shared content, explain why:
```bash
git commit -m "feat: Add code review agent

This agent helps review code changes before commits.
Useful for all projects to maintain code quality."
```

## Migration Guide

### From Project-Specific to Shared

If you have agents/commands in a project that should be shared:

1. **Copy to .shared:**
   ```bash
   cp my-project/.claude/agents/useful-agent.md ~/claude-templates/.shared/agents/
   ```

2. **Test in another project:**
   ```bash
   cd other-project/.claude
   ls -la agents/  # Should see useful-agent.md via symlink
   ```

3. **Remove from original project:**
   ```bash
   # Already there via symlink, nothing to do!
   ```

4. **Commit:**
   ```bash
   cd ~/claude-templates
   git add .shared/agents/useful-agent.md
   git commit -m "feat: Share useful-agent across all projects"
   git push
   ```

## Advanced Usage

### Custom Templates

Create your own template:

```bash
cd ~/claude-templates/templates
mkdir my-custom-template/.claude
cd my-custom-template/.claude

# Link to shared
ln -s ../../../.shared/agents agents
ln -s ../../../.shared/commands commands
ln -s ../../../.shared/skills skills

# Add specialized content
mkdir -p specialized/{agents,commands,skills}
# Add your custom agents/commands here

# Create template README
nano README.md
```

### Per-Project Overrides

If you need to override a shared agent for one project:

1. **Don't edit the symlinked version** (affects all projects)
2. **Create a local override:**
   ```bash
   # Copy and modify locally
   cp agents/codebase-analyzer.md codebase-analyzer-local.md
   # Edit codebase-analyzer-local.md
   ```
3. **Reference the local version** in your instructions.md

### Multi-Repository Setup

If you have projects in different locations:

```bash
# Use absolute paths in symlinks
cd ~/work/project1/.claude
ln -s ~/Documents/PRIVATE/claude-templates/.shared/agents agents

cd ~/personal/project2/.claude
ln -s ~/Documents/PRIVATE/claude-templates/.shared/agents agents

# Both projects use the same shared configuration
```

## Summary

**Single Point of Change:** Edit `.shared/` → All projects updated instantly

**Layered Architecture:**
1. Shared (universal)
2. Template-specific (domain)
3. Project-specific (context)

**Easy Setup:** One command to configure any project

**Git-Friendly:** Track changes, version control, collaborate

**Scalable:** Add new projects easily, maintain consistency

For more information, see:
- [.shared/README.md](../.shared/README.md) - Shared configuration details
- [templates/](../templates/) - Available templates
- [scripts/setup-claude.sh](../scripts/setup-claude.sh) - Setup script source
