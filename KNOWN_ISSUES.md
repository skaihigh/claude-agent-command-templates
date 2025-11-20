# Known Issues & Project-Specific References

This document lists all project-specific references in the shared agents and commands that need to be adapted for use in other projects.

**Last Updated:** 2025-11-20

---

## 🚨 Critical Issues (Must Fix Before Sharing)

These files contain hardcoded references to the VSSK-shadecn music practice application and will not work correctly in other projects without modification.

### Agents

| Agent File | Issue | Line(s) | Severity |
|------------|-------|---------|----------|
| **test-engineer.md** | References "VSSK-shadecn" project name | 9, 33, 42, 144 | 🔴 CRITICAL |
| **accessibility-expert.md** | References "VSSK-shadecn" and "young musicians age 10+" | 3, 9, 40-47, 144 | 🔴 CRITICAL |
| **audio-engineer.md** | References "VSSK-shadecn music practice application" | 3, 9, 40-47 | 🔴 CRITICAL |
| **pwa-specialist.md** | References "VSSK-shadecn" requirements | 9, 42-50, 51 | 🔴 CRITICAL |
| **react-architect.md** | References "VSSK-shadecn" tech stack | 42-49, 138-163 | 🔴 CRITICAL |

### Commands

| Command File | Issue | Line(s) | Severity |
|-------------|-------|---------|----------|
| **create_plan.md** | Assumes Python/LangChain file structure (agents.py, tools.py, graph.py) | 378-395 | 🔴 CRITICAL |
| **research_codebase.md** | Hardcoded repository name "langChain_and_subAgents" | 98 | 🔴 CRITICAL |
| **storybook-audit.md** | Contains example paths from audio application | 74-78, 100-104, 112-122 | 🔴 CRITICAL |
| **audio-impl.md** | Audio application specific - not generic | Entire file | 🔴 CRITICAL |
| **research-tech.md** | Hardcoded "VSSK-shadecn" project name and tech stack | 15, 17, 19, 23 | 🔴 CRITICAL |
| **test-coverage.md** | Audio app specific critical paths (audio playback, save points) | 14-18 | 🔴 CRITICAL |
| **ship.md** | Examples use audio app features (SavePoints, player, library) | 60-67, 90-101, 151-198 | 🔴 CRITICAL |

---

## ⚠️ Moderate Issues (Should Fix)

These files have some project-specific assumptions but can work with minor adaptations.

### Agents

| Agent File | Issue | Severity |
|------------|-------|----------|
| **storybook-expert.md** | References test-engineer agent | 🟡 MODERATE |
| **visualization-expert.md** | Examples use "VSSK Music Practice App" | 🟡 MODERATE |

### Commands

| Command File | Issue | Severity |
|-------------|-------|----------|
| **create_handoff.md** | Hardcoded repository name | 🟡 MODERATE |
| **create-story.md** | AudioPlayer component example | 🟡 MODERATE |
| **a11y-audit.md** | Age-appropriate section (10+ reading level) | 🟡 MODERATE |
| **new-component.md** | React-specific, not labeled as such | 🟡 MODERATE |
| **phase-status.md** | Assumes ROADMAP.md with numbered phases 1-8 | 🟡 MODERATE |
| **pwa-check.md** | PWA-specific, not clearly labeled | 🟡 MODERATE |
| **validate-fix.md** | Uses pnpm commands (should be generic) | 🟡 MODERATE |

---

## ℹ️ Minor Issues (Nice to Fix)

These files have minor assumptions that are generally reasonable.

### Commands

| Command File | Issue | Severity |
|-------------|-------|----------|
| **implement_plan.md** | Assumes Python tooling (pytest, mypy, ruff) | 🟢 MINOR |
| **resume_handoff.md** | Assumes docs/handoffs/ directory | 🟢 MINOR |
| **validate_plan.md** | Assumes Python tooling | 🟢 MINOR |
| **docs-audit.md** | Assumes specific doc structure | 🟢 MINOR |

---

## 📋 Detailed Breakdown

### test-engineer.md

**Problem:**
- Hardcoded "VSSK-shadecn" project name throughout
- Project-specific testing priorities (audio playback, save points, offline functionality)

**Fix Required:**
```markdown
# BEFORE
You are a testing specialist focused on creating comprehensive, maintainable test suites for VSSK-shadecn.

## Project Context
VSSK-shadecn testing priorities:
1. **Audio playback** - Critical path, must work flawlessly
2. **Offline functionality** - PWA features must work without network

# AFTER
You are a testing specialist focused on creating comprehensive, maintainable test suites for modern web applications.

## Project Context
When working on a project, identify testing priorities based on:
1. **Critical user flows** - Features that must work flawlessly
2. **Data integrity** - Data that must not be lost
```

---

### accessibility-expert.md

**Problem:**
- References "young musicians age 10+" - very specific to music education app
- Hardcoded "VSSK-shadecn" project name

**Fix Required:**
```markdown
# BEFORE
You are a WCAG specialist focused on making VSSK-shadecn accessible to all users, especially young musicians (age 10+) with varying abilities.

## Project Context
VSSK-shadecn must be accessible to:
- **Young musicians** (age 10-18): Clear UI, simple language

# AFTER
You are a WCAG specialist focused on making applications accessible to all users with varying abilities.

## Project Context
When working on a project, identify key user groups who need accessibility support, such as:
- **Target age group**: Adjust language complexity and UI accordingly
```

---

### audio-engineer.md

**Problem:**
- Designed specifically for music practice application
- References "VSSK-shadecn" by name

**Fix Required:**
```markdown
# BEFORE
You are a specialized audio engineering expert focused on implementing professional-grade audio features for the VSSK-shadecn music practice application.

## Project Context
You're working on VSSK-shadecn, a PWA for brass band musicians that requires:
- **Variable speed control** without pitch changes

# AFTER
You are a specialized audio engineering expert focused on implementing professional-grade audio features for web applications and PWAs with audio requirements.

## Project Context
When working on audio-enabled projects, common requirements may include:
- **Variable speed control** without pitch changes (time-stretching algorithms)
```

---

### pwa-specialist.md

**Problem:**
- References "VSSK-shadecn music practice application"
- Project-specific caching strategy

**Fix Required:**
```markdown
# BEFORE
You are a Progressive Web App expert focused on creating a robust offline-first experience for VSSK-shadecn, a music practice application.

## Caching Strategy for VSSK-shadecn

# AFTER
You are a Progressive Web App expert focused on creating robust offline-first experiences for web applications.

## Caching Strategy Examples
```

---

### react-architect.md

**Problem:**
- "Component Patterns for VSSK-shadecn" section
- Assumes specific tech stack (React 18, Vite, shadcn/ui, TanStack Query, CSS Modules)

**Fix Required:**
```markdown
# BEFORE
## Project Context
VSSK-shadecn is a music practice PWA built with:
- **React 18** with concurrent features
- **Vite** for blazing fast builds

## Component Patterns for VSSK-shadecn

# AFTER
## Project Context
When working on a React project, identify the tech stack and adapt patterns accordingly. Common modern React stacks include:
- **React 18+** with concurrent features
- **Build tools** (Vite, webpack, Next.js, etc.)

## Common Component Patterns
```

---

### create_plan.md

**Problem:**
- "Common Patterns" section assumes Python/LangChain structure
- References agents.py, tools.py, graph.py, main.py

**Fix Required:**
```markdown
# BEFORE
## Common Patterns

### For New Agents:
- Research existing agent patterns first
- Start with agent definition in agents.py
- Add required tools in tools.py
- Update graph routing in graph.py
- Add to main.py CLI if needed

# AFTER
## Common Patterns

### For New Features:
- Research existing patterns first
- Identify architectural conventions in the codebase
- Follow established patterns for similar features
- Update configuration/routing as needed
```

---

### research_codebase.md

**Problem:**
- Hardcoded repository name "langChain_and_subAgents" in YAML frontmatter

**Fix Required:**
```yaml
# BEFORE
repository: langChain_and_subAgents

# AFTER
repository: [Repository Name - Update This]
```

---

### storybook-audit.md

**Problem:**
- Contains example output with actual component paths from VSSK-shadecn:
  - `src/components/audio/AudioPlayer.tsx`
  - `src/components/audio/Looper.tsx`
  - References to admin features and audio-specific components

**Fix Required:**
- Remove all example component paths
- Replace with generic placeholders or remove examples entirely
- Keep only the workflow/instructions

---

### audio-impl.md

**Problem:**
- Entire command is audio application specific
- References PROJECT-VISION.md and TECHNOLOGY.md that won't exist in other projects

**Recommended Action:**
- Move to project-specific directory (NOT in .shared/)
- Or completely genericize to "Implement feature with best practices"

---

### research-tech.md

**Problem:**
- Hardcoded project name "VSSK-shadecn"
- Specific tech stack "React, TypeScript, Vite"
- Mobile browser assumptions "iOS Safari, Chrome Android"

**Fix Required:**
```markdown
# BEFORE
## VSSK-shadecn Fit
- **Tech Stack Compatibility**: React, TypeScript, Vite
- **Browser Support**: iOS Safari, Chrome Android

# AFTER
## Project Fit
- **Tech Stack Compatibility**: [Your tech stack]
- **Browser Support**: [Your target browsers]
```

---

### test-coverage.md

**Problem:**
- Audio app specific critical paths:
  - "Audio playback functionality"
  - "Save point persistence"
  - "Offline data sync"

**Fix Required:**
```markdown
# BEFORE
2. **Identify Critical Paths**
   - Audio playback functionality
   - Save point persistence
   - Offline data sync

# AFTER
2. **Identify Critical Paths**
   - Core user workflows
   - Data persistence and integrity
   - External integrations
```

---

### ship.md

**Problem:**
- All examples use audio application features:
  - SavePoints, LoopSection, player components
  - i18n files for "player", "library", "practice"
  - Commit scopes: "player", "library", "admin"

**Fix Required:**
- Replace all examples with generic ones
- Use standard features like: auth, dashboard, api, components, utils

---

### validate-fix.md

**Problem:**
- All commands use `pnpm` package manager
- Assumes Node.js/TypeScript project

**Fix Required:**
```markdown
# BEFORE
pnpm format
pnpm lint --fix
pnpm tsc
pnpm test:run

# AFTER
Run your project's format command (e.g., `npm run format`, `pnpm format`, `cargo fmt`)
Run your project's lint command with auto-fix (e.g., `npm run lint --fix`, `cargo clippy --fix`)
Run your project's type checker (e.g., `tsc`, `mypy .`, type checking if applicable)
Run your project's test suite (e.g., `npm test`, `pytest`, `cargo test`)
```

---

## 🛠️ Recommended Actions

### For Immediate Use (Before Sharing):

1. **Critical Priority** - Fix these first:
   - Remove "VSSK-shadecn" from all files
   - Genericize test-engineer.md testing priorities
   - Genericize accessibility-expert.md user personas
   - Remove audio-impl.md from .shared/ (move to project-specific)
   - Fix research-tech.md hardcoded values
   - Remove/genericize examples in ship.md

2. **High Priority** - Fix soon:
   - Make validate-fix.md package manager agnostic
   - Remove repository name from create_handoff.md and research_codebase.md
   - Genericize storybook-audit.md examples
   - Remove Python/LangChain assumptions from create_plan.md

3. **Medium Priority** - Nice to have:
   - Add clear labels to tech-specific commands (React, PWA, Python)
   - Make all agent references optional with fallback instructions
   - Create configuration file for project-specific values

### For Long-Term Maintainability:

1. **Create `.claude-templates.config.json`:**
   ```json
   {
     "projectName": "your-project-name",
     "repository": "your-repo-name",
     "packageManager": "npm",
     "techStack": ["React", "TypeScript", "Vite"],
     "targetBrowsers": ["Chrome", "Firefox", "Safari"],
     "commands": {
       "format": "npm run format",
       "lint": "npm run lint --fix",
       "typecheck": "tsc",
       "test": "npm test"
     }
   }
   ```

2. **Use variables in templates:**
   ```markdown
   You are a testing specialist for {{projectName}}.

   Run the format command: {{commands.format}}
   ```

3. **Create project-specific overrides:**
   ```
   project/
   ├── .claude/
   │   ├── agents/ (symlinked to .shared/agents)
   │   ├── commands/ (symlinked to .shared/commands)
   │   └── overrides/
   │       ├── audio-impl.md (project-specific version)
   │       └── test-engineer.md (project-specific testing priorities)
   ```

---

## ✅ Clean Files (No Issues)

These files are fully generic and ready to use:

### Agents:
- codebase-analyzer.md
- codebase-locator.md
- codebase-pattern-finder.md
- web-search-researcher.md
- mobile-first-expert.md

### Commands:
- commit.md

---

## 📝 Contributing Fixes

If you fix any of these issues:

1. Update this file to reflect the fix
2. Test the agent/command in a different project
3. Submit changes with clear commit message
4. Update AGENTS_COMMANDS_REFERENCE.md if behavior changed

---

## 🔗 Related Documentation

- [USAGE_GUIDE.md](USAGE_GUIDE.md) - Quick reference for choosing agents/commands
- [AGENTS_COMMANDS_REFERENCE.md](AGENTS_COMMANDS_REFERENCE.md) - Detailed documentation
- [CROSS_PLATFORM_USAGE.md](CROSS_PLATFORM_USAGE.md) - Using with other AI assistants
- [README.md](README.md) - Setup and installation
