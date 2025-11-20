# Cross-Platform AI Assistant Usage Guide

This guide explains how to use the Claude Code Template Library with other AI coding assistants including GitHub Copilot, Cursor AI, Windsurf IDE, and Codeium.

---

## Table of Contents

- [Overview](#overview)
- [Format Comparison](#format-comparison)
- [Platform-Specific Guides](#platform-specific-guides)
  - [GitHub Copilot](#github-copilot)
  - [Cursor AI](#cursor-ai)
  - [Windsurf IDE (Cascade)](#windsurf-ide-cascade)
  - [Codeium](#codeium)
- [Conversion Tools](#conversion-tools)
- [Best Practices](#best-practices)
- [Limitations & Considerations](#limitations--considerations)

---

## Overview

The Claude Code Template Library is designed primarily for **Claude Code** (Anthropic's official CLI for Claude in VS Code), but the agents and commands are essentially **structured markdown documentation** that can be adapted for other AI coding assistants.

### Core Concept

Each agent/command is:
- **A markdown file** with instructions and context
- **Language-agnostic** - focuses on patterns, not implementation
- **Tool-independent** - principles apply across platforms

### Adaptation Strategy

The key to using these templates with other AI assistants is understanding how each platform:
1. **Loads custom instructions** (file location, naming conventions)
2. **Scopes instructions** (global, project, file-specific)
3. **Formats metadata** (YAML frontmatter, MDC, etc.)

---

## Format Comparison

| Platform | File Format | Location | Scope Control | Metadata |
|----------|------------|----------|---------------|----------|
| **Claude Code** | `.md` | `.claude/agents/`, `.claude/commands/` | Directory-based | YAML frontmatter (optional) |
| **GitHub Copilot** | `.instructions.md` | `.github/instructions/` | YAML `applyTo` glob patterns | YAML frontmatter (required) |
| **Cursor AI** | `.mdc` or `.md` | `.cursor/rules/` | Rule type + glob patterns | MDC metadata block |
| **Windsurf IDE** | `.md` | `global_rules.md` or project rules | Global vs project | Simple markdown |
| **Codeium** | Context mentions | No file-based rules | Chat @-mentions | N/A |

---

## Platform-Specific Guides

### GitHub Copilot

GitHub Copilot uses `.instructions.md` files with YAML frontmatter to control when instructions apply.

#### Setup Options

**Option 1: Repository-Wide Instructions**

```bash
# Create repository-wide instructions
mkdir -p .github
cat > .github/copilot-instructions.md << 'EOF'
# Project Coding Standards

## Architecture Principles
[Copy content from .shared/agents/react-architect.md]

## Testing Standards
[Copy content from .shared/agents/test-engineer.md]

## Accessibility Requirements
[Copy content from .shared/agents/accessibility-expert.md]
EOF
```

**Option 2: Path-Scoped Instructions**

```bash
# Create path-scoped instructions
mkdir -p .github/instructions

# React components
cat > .github/instructions/react-components.instructions.md << 'EOF'
---
applyTo: "src/components/**/*.{ts,tsx}"
description: "React component development standards"
---

# React Component Standards

[Copy content from .shared/agents/react-architect.md]

## Key Principles
- Atomic design patterns
- TypeScript strict mode
- Accessibility built-in
- Mobile-first responsive design
EOF

# Tests
cat > .github/instructions/testing.instructions.md << 'EOF'
---
applyTo: "**/*.test.{ts,tsx},**/*.spec.{ts,tsx}"
description: "Testing standards and patterns"
---

# Testing Standards

[Copy content from .shared/agents/test-engineer.md]
EOF

# Audio features
cat > .github/instructions/audio.instructions.md << 'EOF'
---
applyTo: "src/features/audio/**/*.{ts,tsx}"
description: "Web Audio API implementation standards"
---

# Audio Implementation Standards

[Copy content from .shared/agents/audio-engineer.md]
EOF
```

**Option 3: Agent-Specific Instructions**

```bash
# Exclude from code review, only for coding agent
cat > .github/instructions/coding-agent-only.instructions.md << 'EOF'
---
applyTo: "**/*.{ts,tsx}"
excludeAgent: "code-review"
description: "Coding agent specific instructions"
---

# Coding Standards
[Your instructions here]
EOF
```

#### Converting Agents to Copilot Instructions

**Manual Conversion Process:**

1. **Choose scope** (repository-wide or path-specific)
2. **Add YAML frontmatter** with `applyTo` glob pattern
3. **Copy agent content** (remove Claude Code-specific references)
4. **Simplify to actionable guidelines** (Copilot works best with clear, concise rules)

**Example: Converting React Architect Agent**

```markdown
---
applyTo: "src/**/*.{ts,tsx}"
description: "React + TypeScript architecture standards"
---

# React Architecture Standards

## Component Structure
- Use atomic design principles (atoms → molecules → organisms)
- Composition over inheritance
- Custom hooks for shared logic

## TypeScript Excellence
- Strict type safety
- Generic components where appropriate
- Discriminated unions for complex state

## Performance
- Code splitting with React.lazy
- React.memo for expensive components
- Virtual scrolling for long lists

## State Management
- Server state: TanStack Query
- Global UI state: React Context (minimal)
- Local state: useState/useReducer
- Persistent state: IndexedDB hooks

## File Organization
components/
  ComponentName/
    ComponentName.tsx
    ComponentName.test.tsx
    ComponentName.stories.tsx
    ComponentName.module.css
    types.ts
    index.ts
```

#### Limitations

- ❌ No slash command support (commands don't translate directly)
- ❌ No agent invocation (can't "call" an agent)
- ⚠️ Instructions are passive (applied automatically based on file context)
- ⚠️ Works best with clear, actionable guidelines rather than workflows

---

### Cursor AI

Cursor AI uses `.cursorrules` (legacy) or `.cursor/rules/` with `.mdc` format (modern).

#### Setup Options

**Option 1: Legacy .cursorrules File (Simple)**

```bash
# Create a single .cursorrules file in project root
cat > .cursorrules << 'EOF'
# Project Coding Standards

[Copy content from multiple agents into sections]

## React Architecture
[Content from react-architect.md]

## Testing Standards
[Content from test-engineer.md]

## Accessibility
[Content from accessibility-expert.md]

## Audio Implementation
[Content from audio-engineer.md]
EOF
```

**Option 2: Modern .cursor/rules with .mdc Files (Recommended)**

```bash
# Create Cursor rules directory
mkdir -p .cursor/rules

# Create individual rule files
cat > .cursor/rules/react-architecture.mdc << 'EOF'
---
title: React Architecture Standards
description: React + TypeScript component design and state management
type: always
globs:
  - "src/**/*.tsx"
  - "src/**/*.ts"
---

# React Architecture Standards

[Copy content from .shared/agents/react-architect.md]

## Key Principles
- Atomic design patterns
- TypeScript strict mode
- Performance optimization
- Accessibility built-in
EOF

cat > .cursor/rules/testing.mdc << 'EOF'
---
title: Testing Standards
description: Unit, integration, and E2E testing patterns
type: always
globs:
  - "**/*.test.ts"
  - "**/*.test.tsx"
  - "**/*.spec.ts"
---

# Testing Standards

[Copy content from .shared/agents/test-engineer.md]
EOF

cat > .cursor/rules/audio-engineering.mdc << 'EOF'
---
title: Audio Implementation
description: Web Audio API best practices
type: always
globs:
  - "src/features/audio/**/*"
  - "src/hooks/useAudio*"
---

# Audio Engineering Standards

[Copy content from .shared/agents/audio-engineer.md]
EOF
```

#### Global User Rules

```bash
# Access via Cursor Settings > General > Rules for AI
# Add personal preferences that apply to all projects
```

Example global rules:
```markdown
# Global Coding Preferences

- Always use TypeScript strict mode
- Prefer functional components over class components
- Write clear, descriptive commit messages
- Include unit tests for all new functions
- Document complex algorithms with comments
```

#### Converting Commands to Cursor Workflows

Cursor supports custom workflows (similar to commands). While the Claude Code commands won't work directly, you can create Cursor-specific workflows:

```markdown
# Example: Converting /create_plan command to Cursor workflow
# Save as .cursor/workflows/create-plan.md

When I ask you to create an implementation plan:

1. Research the codebase using grep and file reading
2. Identify all relevant files and patterns
3. Create a phased implementation plan
4. Write to docs/plans/YYYY-MM-DD-description.md
5. Include success criteria (automated + manual)
6. List what we're NOT doing to prevent scope creep

[Copy workflow steps from .shared/commands/create_plan.md]
```

#### Limitations

- ❌ No native agent system (rules are always applied based on context)
- ⚠️ Commands require manual adaptation to workflows
- ⚠️ Less granular control than Claude Code's agent system

---

### Windsurf IDE (Cascade)

Windsurf IDE uses a `global_rules.md` file and supports custom workflows with slash commands.

#### Setup Options

**Option 1: Global Rules**

```bash
# Access via Cascade window > Three dots > Manage memories > Edit global rules
# Or open global_rules.md directly

# Add content from shared agents
cat >> global_rules.md << 'EOF'

## React Architecture
[Copy from .shared/agents/react-architect.md]

## Testing Standards
[Copy from .shared/agents/test-engineer.md]

## Accessibility
[Copy from .shared/agents/accessibility-expert.md]
EOF
```

**Option 2: Project-Specific Rules**

Create project-specific rules files and reference them in your project:

```bash
mkdir -p .windsurf
cat > .windsurf/project-rules.md << 'EOF'
# Project Coding Standards

[Combine content from relevant agents]
EOF
```

#### Creating Custom Workflows (Slash Commands)

Windsurf supports custom workflows that can be invoked with slash commands:

```bash
# Example: Convert /create_plan to Windsurf workflow
cat > .windsurf/workflows/create-plan.md << 'EOF'
# /create-plan - Create Implementation Plan

When invoked:
1. Research codebase context
2. Ask user for task description
3. Identify all relevant files
4. Create phased implementation plan
5. Write to docs/plans/YYYY-MM-DD-description.md
6. Include success criteria

[Copy workflow from .shared/commands/create_plan.md]
EOF
```

Register the workflow in Windsurf settings to make it available as a slash command.

#### Limitations

- ⚠️ Workflow setup requires manual configuration
- ⚠️ Less mature ecosystem than Cursor/Copilot
- ⚠️ Memory management needs regular maintenance

---

### Codeium

Codeium doesn't support file-based custom instructions in the same way. It relies on context mentions and pinning.

#### Setup Options

**Option 1: Context Pinning**

```bash
# 1. Create a docs/coding-standards.md file
cat > docs/coding-standards.md << 'EOF'
# Coding Standards

## React Architecture
[Copy from .shared/agents/react-architect.md]

## Testing
[Copy from .shared/agents/test-engineer.md]

## Accessibility
[Copy from .shared/agents/accessibility-expert.md]
EOF

# 2. In Codeium Chat, pin this file
# This makes it always available in context
```

**Option 2: Use .codeiumignore for Context Control**

```bash
# Exclude non-relevant files from context
cat > .codeiumignore << 'EOF'
node_modules/
dist/
build/
*.log
.env
EOF
```

**Option 3: @-Mentions in Chat**

When asking Codeium for help, explicitly mention context:

```
@docs/coding-standards.md @src/components/AudioPlayer.tsx

Please implement variable speed playback following our audio engineering standards.
```

#### Converting Agents to Documentation

Since Codeium doesn't have native rule files, create well-organized documentation that you can @-mention:

```bash
mkdir -p docs/standards

# Create focused documentation files
cat > docs/standards/react-patterns.md << 'EOF'
# React Patterns

[Copy from .shared/agents/react-architect.md, simplified]
EOF

cat > docs/standards/testing-guide.md << 'EOF'
# Testing Guide

[Copy from .shared/agents/test-engineer.md, simplified]
EOF
```

#### Limitations

- ❌ No automatic instruction loading
- ❌ Requires manual context mentions in each chat
- ⚠️ Best for smaller, focused tasks
- ⚠️ Context window limits apply

---

## Conversion Tools

### Automated Conversion Tools

#### 1. **rulesync** - Unified AI Configuration Manager

```bash
# Install
npm install -g rulesync

# Convert to multiple formats
npx rulesync --cursor --claudecode --copilot

# Options:
# --cursor: Generate .cursorrules
# --claudecode: Generate CLAUDE.md
# --copilot: Generate .github/copilot-instructions.md
```

**Repository:** Community tool for managing rules across platforms

---

#### 2. **cursor-rules-to-claude** - Cursor → Claude Converter

```bash
# Convert Cursor rules to CLAUDE.md
npx cursor-rules-to-claude --rules-dir .cursor/rules --output CLAUDE.md

# Options:
# --overwrite: Overwrite existing CLAUDE.md
# --rules-dir: Source directory (default: .cursor/rules)
# --output: Output file (default: CLAUDE.md)
```

**Note:** This works Cursor → Claude, but demonstrates the conversion process

---

### Manual Conversion Scripts

#### Shell Script for Batch Conversion

```bash
#!/bin/bash
# convert-to-copilot.sh

# Converts Claude Code agents to GitHub Copilot instructions

AGENTS_DIR=".shared/agents"
OUTPUT_DIR=".github/instructions"

mkdir -p "$OUTPUT_DIR"

for agent_file in "$AGENTS_DIR"/*.md; do
  agent_name=$(basename "$agent_file" .md)

  # Create instruction file with YAML frontmatter
  cat > "$OUTPUT_DIR/${agent_name}.instructions.md" << EOF
---
applyTo: "**/*.{ts,tsx,js,jsx}"
description: "${agent_name} standards"
---

EOF

  # Append agent content (skip YAML frontmatter if exists)
  sed '/^---$/,/^---$/d' "$agent_file" >> "$OUTPUT_DIR/${agent_name}.instructions.md"

  echo "Converted: $agent_name"
done

echo "Conversion complete! Check $OUTPUT_DIR/"
```

Usage:
```bash
chmod +x convert-to-copilot.sh
./convert-to-copilot.sh
```

---

## Best Practices

### 1. **Keep It Simple**

Most AI assistants work best with clear, concise instructions:

✅ **Good:**
```markdown
## Component Structure
- Use functional components with TypeScript
- Props interface above component
- Export component as default
```

❌ **Too Complex:**
```markdown
## Component Structure
When creating components, you must follow the architectural pattern
established in src/patterns/component-design.md which specifies that
all components should adhere to the functional paradigm while ensuring
TypeScript strict mode compliance...
```

---

### 2. **Scope Appropriately**

Different scopes for different needs:

- **Global/Repository-wide:** General coding standards, language preferences
- **Path-specific:** Domain-specific patterns (audio/, components/, tests/)
- **File-specific:** Very specialized rules for specific file types

---

### 3. **Test Incrementally**

Don't convert everything at once:

1. Start with 1-2 key agents (e.g., react-architect, test-engineer)
2. Test in a real coding session
3. Refine based on AI behavior
4. Gradually add more agents

---

### 4. **Maintain Consistency**

If using multiple AI assistants:

- Keep a **canonical source** (Claude Code templates)
- Use **conversion scripts** to generate platform-specific files
- **Version control** all rule files
- **Document** which platform uses which files

Example `.gitignore`:
```gitignore
# Keep platform-specific rules in version control
!.github/instructions/*.md
!.cursor/rules/*.mdc
!.cursorrules
!global_rules.md
```

---

### 5. **Document Conversions**

Create a `README-AI-RULES.md` in your project:

```markdown
# AI Assistant Configuration

This project uses AI coding assistants with custom instructions.

## Claude Code
- Location: `.claude/agents/`, `.claude/commands/`
- Source: Symlinked from ~/claude-templates/.shared/

## GitHub Copilot
- Location: `.github/instructions/*.instructions.md`
- Converted from Claude Code agents on: 2025-11-20
- Conversion script: `scripts/convert-to-copilot.sh`

## Cursor AI
- Location: `.cursor/rules/*.mdc`
- Manually maintained
- Synced with Claude Code templates quarterly

## Update Process
1. Edit Claude Code templates in ~/claude-templates/.shared/
2. Run `./scripts/convert-to-copilot.sh`
3. Manually update Cursor rules if needed
4. Commit all changes together
```

---

## Limitations & Considerations

### Platform Limitations

| Platform | Limitation | Workaround |
|----------|-----------|------------|
| **GitHub Copilot** | No slash commands | Create documentation with examples |
| **Cursor AI** | No agent invocation | Use rule scoping with globs |
| **Windsurf** | Memories can be incorrect | Regular memory audits |
| **Codeium** | No automatic rule loading | Pin documentation files |

---

### Command Translation Challenges

Claude Code **commands** (slash commands) are **procedural workflows** that don't translate directly to other platforms:

**Claude Code `/create_plan`:**
- Spawns sub-agents
- Reads files
- Creates todo lists
- Writes plan to `docs/plans/`
- Interactive iteration

**GitHub Copilot equivalent:**
- ❌ No direct equivalent
- ✅ Can create "Planning Checklist" documentation
- ✅ User manually follows checklist with Copilot assistance

**Recommendation:**
- Convert **commands** to **documentation** with step-by-step checklists
- Use AI assistant interactively to follow the steps
- Accept that full automation isn't possible on all platforms

---

### Agent vs Rules

| Claude Code Agents | Other Platform Rules |
|-------------------|---------------------|
| Can be invoked explicitly | Applied automatically by context |
| Can spawn sub-agents | No nesting/composition |
| Interactive workflows | Passive guidelines |
| Tool access (Read, Grep, Bash) | Limited to AI model capabilities |

**Best Practice:**
- Use **agents** in Claude Code for complex workflows
- Use **rules** in other platforms for coding standards and patterns
- Keep both in sync where possible

---

## Summary

### Quick Decision Matrix

**Choose Claude Code if you want:**
- ✅ Sophisticated agent workflows
- ✅ Slash commands for common tasks
- ✅ Interactive, iterative processes
- ✅ Deep codebase analysis

**Choose GitHub Copilot if you want:**
- ✅ Simple, path-scoped instructions
- ✅ Native GitHub integration
- ✅ Organization-wide standards
- ✅ Mature, stable platform

**Choose Cursor AI if you want:**
- ✅ Flexible rule system
- ✅ Modern IDE experience
- ✅ Good balance of power and simplicity
- ✅ Active development community

**Choose Windsurf IDE if you want:**
- ✅ Custom workflows as slash commands
- ✅ Memory-based learning
- ✅ Cutting-edge AI features
- ✅ Willing to manage memories

**Choose Codeium if you want:**
- ✅ Free option
- ✅ Simple setup
- ✅ Manual context control
- ✅ Good autocomplete

---

### Hybrid Approach

**Best of Both Worlds:**

Many developers use **multiple AI assistants**:

1. **Claude Code** for complex planning, architecture decisions, and refactoring
2. **GitHub Copilot** for day-to-day code completion and simple tasks
3. **Cursor AI** as daily driver with occasional Claude Code usage

**Setup:**
```
project/
├── .claude/          # Claude Code agents & commands
│   ├── agents/       # Symlinked to ~/claude-templates/.shared/agents/
│   └── commands/     # Symlinked to ~/claude-templates/.shared/commands/
├── .github/
│   └── instructions/ # Generated from Claude Code agents
│       └── *.instructions.md
└── .cursor/
    └── rules/        # Manually synced quarterly
        └── *.mdc
```

---

## Next Steps

1. **Choose your platform(s)** based on your needs
2. **Start small** - convert 1-2 key agents
3. **Test in real work** - see what works
4. **Iterate and refine** - adjust based on AI behavior
5. **Automate** - create conversion scripts once you're happy

For detailed agent descriptions, see [AGENTS_COMMANDS_REFERENCE.md](AGENTS_COMMANDS_REFERENCE.md).

For setup instructions, see [README.md](README.md).
