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

## Universal Agents (10 total)

### Codebase Analysis
- **codebase-analyzer.md** - Analyzes codebase implementation details
- **codebase-locator.md** - Locates files, directories, and components
- **codebase-pattern-finder.md** - Finds similar implementations and patterns

### Development Specialists
- **test-engineer.md** - Testing specialist for unit, integration, E2E tests
- **storybook-expert.md** - Storybook component development and atomic design
- **react-architect.md** - React + TypeScript architecture and best practices
- **accessibility-expert.md** - WCAG compliance and accessibility testing

### Domain Specialists
- **audio-engineer.md** - Web Audio API, audio processing, and caching
- **pwa-specialist.md** - Progressive Web Apps, service workers, offline-first
- **web-search-researcher.md** - Web research and information gathering

## Universal Commands (19 total)

### Planning & Implementation
- **create_plan.md** (`/create_plan`) - Create detailed implementation plans
- **implement_plan.md** (`/implement_plan`) - Implement technical plans with verification
- **validate_plan.md** (`/validate_plan`) - Validate implementation against plans
- **validate-fix.md** (`/validate-fix`) - Validate and fix implementation issues

### Git & Deployment
- **commit.md** (`/commit`) - Create git commits with proper workflow
- **ship.md** (`/ship`) - Ship features to production with checklist

### Handoffs & Documentation
- **create_handoff.md** (`/create_handoff`) - Create handoff documents
- **resume_handoff.md** (`/resume_handoff`) - Resume work from handoffs
- **research_codebase.md** (`/research_codebase`) - Document codebase comprehensively

### Component Development
- **new-component.md** (`/new-component`) - Create new React components
- **create-story.md** (`/create-story`) - Create Storybook stories for components
- **storybook-audit.md** (`/storybook-audit`) - Audit codebase for Storybook opportunities

### Audits & Quality
- **docs-audit.md** (`/docs-audit`) - Audit and improve documentation
- **test-coverage.md** (`/test-coverage`) - Analyze test coverage
- **a11y-audit.md** (`/a11y-audit`) - Comprehensive accessibility audit
- **pwa-check.md** (`/pwa-check`) - Check PWA configuration and offline functionality

### Domain-Specific
- **audio-impl.md** (`/audio-impl`) - Implement audio features with best practices
- **research-tech.md** (`/research-tech`) - Research technology options
- **phase-status.md** (`/phase-status`) - Check development phase status

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

## Philosophy: Universal vs Specialized

**Universal (here in .shared/):**
All agents and commands that are useful across multiple projects are now stored centrally. This includes:
- Codebase analysis tools (analyzer, locator, pattern-finder)
- Development specialists (test-engineer, storybook-expert, react-architect)
- Domain specialists (audio-engineer, pwa-specialist, accessibility-expert)
- Planning and implementation commands
- Quality and audit commands
- Component development tools

**Project-specific (in project/.claude/):**
- instructions.md (project context and guidelines)
- settings.local.json (project permissions and MCP configuration)
- Project-specific overrides when needed

## Benefits of This Approach

✅ **Single Source of Truth** - Update once, all projects benefit
✅ **Consistent Tooling** - Same capabilities across all projects
✅ **Easy Maintenance** - No duplication, no drift
✅ **Instant Updates** - Symlinks mean changes propagate immediately
✅ **Git-Tracked** - Version controlled shared configuration
✅ **Portable** - Easy to set up new projects

## Detailed Documentation

For comprehensive descriptions of each agent and command, see:
- **[Quick Usage Guide](../USAGE_GUIDE.md)** ⭐ START HERE - "I want to..." quick reference table
- **[Agents & Commands Reference](../AGENTS_COMMANDS_REFERENCE.md)** - Detailed guide with examples and use cases
- **[Cross-Platform Usage](../CROSS_PLATFORM_USAGE.md)** - How to use with other AI assistants (Copilot, Cursor, Windsurf, Codeium)
- **[Known Issues](../KNOWN_ISSUES.md)** ⚠️ IMPORTANT - Project-specific references that need adaptation before sharing

## Recently Added (2025-11-17)

**New Agents:**
- `storybook-expert.md` - Comprehensive Storybook expertise with atomic design
- `accessibility-expert.md` - WCAG compliance and a11y testing
- `audio-engineer.md` - Web Audio API specialist
- `pwa-specialist.md` - Progressive Web App expert
- `react-architect.md` - React + TypeScript architecture
- `mobile-first-expert.md` - Mobile-first design and touch interface optimization
- `visualization-expert.md` - Diagrams-as-code and accessible visualizations

**New Commands:**
- `/create-story` - Create Storybook stories with tests and a11y
- `/storybook-audit` - Analyze codebase for Storybook opportunities
- `/docs-audit` - Audit and improve documentation
- `/a11y-audit` - Comprehensive accessibility audit
- `/test-coverage` - Analyze test coverage
- `/new-component` - Create new React components
- `/pwa-check` - Check PWA configuration
- `/audio-impl` - Implement audio features
- `/research-tech` - Research technology options
- `/validate-fix` - Validate and auto-fix code quality
- `/ship` - Ship features to production
