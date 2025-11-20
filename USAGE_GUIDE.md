# Quick Usage Guide

A practical guide to choosing the right agents and commands for your task.

---

## 🎯 I Want To... (Quick Reference)

| I want to... | Use these Agents | Use these Commands | Notes |
|-------------|------------------|-------------------|-------|
| **Understand how existing code works** | `codebase-analyzer` | `/research_codebase` | Analyzer explains HOW it works, research creates docs |
| **Find files related to a feature** | `codebase-locator` | - | Returns categorized file lists |
| **Find examples of similar code** | `codebase-pattern-finder` | - | Shows working examples you can follow |
| **Plan a new feature** | `codebase-analyzer`<br>`codebase-locator`<br>`codebase-pattern-finder` | `/create_plan` | Plan command uses all 3 agents automatically |
| **Implement a planned feature** | (varies by feature) | `/implement_plan` | Executes an existing plan document |
| **Create React components** | `react-architect`<br>`accessibility-expert` | `/new-component` | **React projects only** |
| **Add Storybook stories** | `storybook-expert` | `/storybook-audit`<br>`/create-story` | Audit first, then create stories |
| **Test my code** | `test-engineer` | `/test-coverage` | Coverage shows gaps, engineer writes tests |
| **Make my app accessible** | `accessibility-expert` | `/a11y-audit` | Audit finds issues, expert fixes them |
| **Build a PWA** | `pwa-specialist` | `/pwa-check` | **PWA projects only** |
| **Work with audio** | `audio-engineer` | `/audio-impl` | **Audio apps only** - *Move to project-specific* |
| **Optimize for mobile** | `mobile-first-expert` | - | Design patterns and best practices |
| **Create diagrams** | `visualization-expert` | - | Architecture, flow, data diagrams |
| **Research a library/technology** | `web-search-researcher` | `/research-tech` | Evaluates tech against your project |
| **Improve documentation** | - | `/docs-audit` | Organizes and validates docs |
| **Commit changes** | - | `/commit` | Smart commit grouping |
| **Ship to production** | - | `/validate-fix`<br>`/ship` | Quality checks + git workflow |
| **Pause work and handoff** | - | `/create_handoff` | Creates resumable context document |
| **Resume previous work** | - | `/resume_handoff` | Picks up from handoff document |
| **Validate implementation** | `codebase-analyzer` | `/validate_plan` | Compares implementation vs plan |

---

## 📋 Common Workflows

### 🎨 Building a New Feature

```
1. /create_plan          → Creates phased implementation plan
   (Uses: codebase-analyzer, codebase-locator, codebase-pattern-finder)

2. /implement_plan       → Executes the plan phase by phase
   (Uses: Relevant domain agents based on feature)

3. /test-coverage        → Identifies missing tests
   (Uses: test-engineer)

4. /validate-fix         → Runs quality checks

5. /commit               → Creates organized commits

6. /ship                 → Ships to production
```

### 🔍 Understanding Existing Code

```
1. codebase-locator      → Find all related files

2. codebase-analyzer     → Understand how it works

3. /research_codebase    → Create documentation
   (Combines locator + analyzer + pattern-finder)
```

### ♿ Making Your App Accessible

```
1. /a11y-audit           → Automated + manual accessibility testing
   (Uses: accessibility-expert)

2. accessibility-expert  → Fix identified issues

3. /test-coverage        → Add accessibility tests
   (Uses: test-engineer)
```

### 📚 Creating Component Library (React + Storybook)

```
1. /storybook-audit      → Identify components needing stories
   (Uses: storybook-expert)

2. /new-component        → Create new components with stories
   (Uses: react-architect, accessibility-expert, storybook-expert)

3. /create-story         → Add stories to existing components
   (Uses: storybook-expert)
```

### 🚀 PWA Development

```
1. pwa-specialist        → Design offline architecture

2. /pwa-check           → Validate PWA configuration
   (Uses: pwa-specialist)

3. mobile-first-expert   → Optimize for mobile UX
```

### 📱 Mobile-First Development

```
1. mobile-first-expert   → Design touch-friendly UI

2. accessibility-expert  → Ensure touch targets meet WCAG

3. /a11y-audit          → Validate mobile accessibility
```

### 🔄 Daily Development Workflow

```
1. [Write code]

2. /validate-fix         → Auto-fix formatting/linting

3. /commit               → Create descriptive commits

   OR

   /ship                 → Validate + commit + push
```

### ⏸️ Handoff Between Sessions

```
// Ending a session
1. /create_handoff       → Create context document

// Starting new session
2. /resume_handoff       → Load context and continue
```

---

## 🏗️ By Project Type

### React + TypeScript Web App

**Essential Agents:**
- `react-architect` - Component design
- `test-engineer` - Testing strategy
- `accessibility-expert` - WCAG compliance

**Recommended Commands:**
- `/new-component` - Scaffold components
- `/create-story` - Storybook stories
- `/a11y-audit` - Accessibility checks

**Optional (based on needs):**
- `storybook-expert` - If building component library
- `pwa-specialist` - If building PWA
- `mobile-first-expert` - If mobile-focused

---

### Progressive Web App (PWA)

**Essential Agents:**
- `pwa-specialist` - Offline-first architecture
- `mobile-first-expert` - Mobile UX patterns
- `accessibility-expert` - Mobile accessibility

**Recommended Commands:**
- `/pwa-check` - Validate PWA setup
- `/a11y-audit` - Mobile accessibility

**Optional:**
- `audio-engineer` - If working with media
- `visualization-expert` - For offline data viz

---

### Python Backend / API

**Essential Agents:**
- `test-engineer` - Testing strategy
- `codebase-analyzer` - Understand data flow

**Recommended Commands:**
- `/create_plan` - Plan features
- `/implement_plan` - Execute plans
- `/test-coverage` - Ensure coverage
- `/validate-fix` - Quality checks (adapt for Python)

**Note:** Several commands assume Python tooling (pytest, mypy, ruff)

---

### Component Library

**Essential Agents:**
- `storybook-expert` - Story creation
- `react-architect` - Component architecture
- `accessibility-expert` - Accessible components

**Recommended Commands:**
- `/storybook-audit` - Find components needing stories
- `/create-story` - Generate stories
- `/new-component` - Create new components
- `/a11y-audit` - Accessibility validation

---

### Mobile App (React Native / Web)

**Essential Agents:**
- `mobile-first-expert` - Mobile UX patterns
- `accessibility-expert` - Touch accessibility
- `react-architect` - Component design

**Recommended Commands:**
- `/a11y-audit` - Mobile accessibility
- `/new-component` - Mobile components

---

### Audio/Music Application

**Essential Agents:**
- `audio-engineer` - Web Audio API
- `pwa-specialist` - Offline audio caching
- `accessibility-expert` - Audio player accessibility
- `mobile-first-expert` - Mobile audio UX

**Recommended Commands:**
- `/audio-impl` - Audio features (*project-specific*)
- `/pwa-check` - Offline functionality
- `/a11y-audit` - Audio accessibility

**⚠️ Note:** `audio-engineer` agent and `/audio-impl` command contain VSSK-shadecn project-specific references. See KNOWN_ISSUES.md for details.

---

## 🎓 By Experience Level

### Beginner (New to AI Assistants)

**Start with these:**
- `/research_codebase` - Understand existing code
- `codebase-locator` - Find files
- `/commit` - Better commit messages

**Then try:**
- `/create_plan` - Plan before coding
- `/a11y-audit` - Learn accessibility
- `/test-coverage` - Understand testing

---

### Intermediate (Familiar with AI coding)

**Use regularly:**
- `/create_plan` + `/implement_plan` - Structured development
- `/validate-fix` + `/commit` - Quality workflow
- `react-architect` / `test-engineer` - Domain expertise

**Explore:**
- `/storybook-audit` - Component documentation
- `/pwa-check` - Offline functionality
- `/docs-audit` - Documentation health

---

### Advanced (Power User)

**Leverage full ecosystem:**
- Combine multiple agents in complex workflows
- Create custom handoff workflows
- Use `/ship` for full deployment automation
- Chain `/research_codebase` → `/create_plan` → `/implement_plan` → `/validate_plan`

**Customize:**
- Adapt commands for your tech stack
- Create project-specific agents
- Build custom workflows

---

## ⚙️ By Technology Stack

### React + TypeScript + Vite

```
Core Agents:
- react-architect
- test-engineer
- accessibility-expert

Commands:
- /new-component
- /create-story
- /validate-fix (adapt for npm/pnpm)
- /ship
```

---

### Next.js / Remix

```
Core Agents:
- react-architect
- pwa-specialist (if using PWA features)
- mobile-first-expert

Commands:
- /new-component
- /a11y-audit
- /validate-fix
```

---

### Python + FastAPI / Django

```
Core Agents:
- test-engineer
- codebase-analyzer

Commands:
- /create_plan
- /implement_plan
- /test-coverage
- /validate-fix (uses pytest, mypy, ruff by default)
```

---

### Vue / Angular

```
Core Agents:
- test-engineer
- accessibility-expert
- storybook-expert (Storybook supports Vue/Angular)

Commands:
- /a11y-audit
- /test-coverage
- /validate-fix (adapt for your tools)

Note: Some React-specific agents may need adaptation
```

---

## 🚫 What NOT to Use (Project-Specific Items)

These items contain references to Christian's VSSK-shadecn project and should be adapted:

### ⚠️ Critical Issues (Don't use as-is):
- `audio-engineer` agent - References "VSSK-shadecn music practice app"
- `pwa-specialist` agent - References "VSSK-shadecn requirements"
- `react-architect` agent - References "VSSK-shadecn" tech stack
- `/audio-impl` command - Audio application specific
- `/research-tech` command - Hardcoded "VSSK-shadecn" project name
- `/test-coverage` command - Audio app critical paths
- `/ship` command - Examples use audio app features

### 📝 Recommended Actions:
1. See [KNOWN_ISSUES.md](KNOWN_ISSUES.md) for complete list
2. Either:
   - **Adapt** these files for your project
   - **Wait** for generic versions
   - **Use with caution** knowing they reference another project

---

## 🔧 Adapting for Your Project

### Quick Fixes

**For Python projects:**
- `/validate-fix` works out of the box (uses pytest, mypy, ruff)

**For Node.js projects:**
- Edit `/validate-fix` to use npm/pnpm commands
- Replace `pnpm format` → `npm run format`

**For Rust/Go/other languages:**
- Adapt `/validate-fix` for your tooling
- Update agent references to match your testing frameworks

### Agent Availability

Some commands reference specialized agents:
- `/create_plan` uses `codebase-*` agents (✅ available)
- `/storybook-audit` uses `storybook-expert` (✅ available)
- `/a11y-audit` uses `accessibility-expert` (✅ available)
- `/test-coverage` uses `test-engineer` (⚠️ has project-specific refs)

**Fallback:** If an agent isn't available or suitable, you can:
1. Use general Task agents
2. Manually perform the analysis
3. Adapt the agent for your project

---

## 📚 Learn More

- **[Agents & Commands Reference](AGENTS_COMMANDS_REFERENCE.md)** - Detailed documentation
- **[Cross-Platform Usage](CROSS_PLATFORM_USAGE.md)** - Use with other AI assistants
- **[Known Issues](KNOWN_ISSUES.md)** - Project-specific references to adapt
- **[README](README.md)** - Setup and installation

---

## 💡 Tips for Success

1. **Start small** - Try 1-2 agents/commands first
2. **Read the docs** - Each agent has specific capabilities
3. **Combine strategically** - Workflows are more powerful than individual tools
4. **Adapt to your stack** - Generic templates need customization
5. **Check for project-specific refs** - See KNOWN_ISSUES.md before using
6. **Create handoffs** - Use `/create_handoff` for long tasks
7. **Validate often** - Use `/validate-fix` frequently
8. **Plan before coding** - `/create_plan` saves time

---

## ❓ Still Not Sure?

**Ask yourself:**
- What's my goal? (Understand code / Build feature / Fix bugs / Ship code)
- What's my tech stack? (React / Python / Other)
- What's my project type? (Web app / PWA / Component library / API)

**Then find the matching section above!**

For specific agent/command details, see [AGENTS_COMMANDS_REFERENCE.md](AGENTS_COMMANDS_REFERENCE.md).
