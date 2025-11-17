# Shared Claude Configuration

This directory contains universal agents, commands, and skills that are shared across all projects.

## Single Point of Change

All files in this directory are symlinked from individual projects, providing:
- **One edit, everywhere updated**: Changes here instantly apply to all projects
- **Consistent capabilities**: All projects get the same base toolset
- **Easy maintenance**: No manual syncing needed

## Directory Structure

```
.shared/
├── agents/          # Universal agents (codebase analysis, research, testing)
├── commands/        # Universal commands (planning, implementation, handoffs)
└── skills/          # Universal skills (reusable skill bundles)
```

## Universal Agents

- **codebase-analyzer.md** - Analyzes codebase implementation details
- **codebase-locator.md** - Locates files, directories, and components
- **codebase-pattern-finder.md** - Finds similar implementations and patterns
- **test-engineer.md** - Testing specialist
- **web-search-researcher.md** - Web research and information gathering

## Universal Commands

- **commit.md** - Create git commits with proper workflow
- **create_handoff.md** - Create handoff documents for transferring work
- **create_plan.md** - Create detailed implementation plans
- **implement_plan.md** - Implement technical plans with verification
- **research_codebase.md** - Document codebase comprehensively
- **resume_handoff.md** - Resume work from handoff documents
- **validate_plan.md** - Validate implementation against plans

## Usage in Projects

Projects symlink to these directories:

```bash
cd your-project/.claude
ln -s /path/to/claude-templates/.shared/agents agents
ln -s /path/to/claude-templates/.shared/commands commands
ln -s /path/to/claude-templates/.shared/skills skills
```

## Adding New Universal Content

1. Add the file to the appropriate directory here
2. All projects with symlinks automatically see the new content
3. Commit to git to track the change

## Template-Specific vs Universal

**Universal (here):**
- Capabilities useful across ALL project types
- General-purpose agents and commands
- Language/framework agnostic

**Template-specific (in templates/):**
- React-specific agents (react-architect, pwa-specialist)
- Music-specific agents (audio-engineer, accessibility-expert)
- Domain-specific commands (audio-impl, pwa-check)

**Project-specific (in project/.claude/):**
- instructions.md (project context and guidelines)
- settings.local.json (project permissions)
- Custom overrides when needed
