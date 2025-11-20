# Configuration Guide

This guide explains how to use `.claude-templates.config.json` to customize the template library for your project.

---

## Quick Start

1. **Copy the example config:**
   ```bash
   cp .claude-templates.config.example.json .claude-templates.config.json
   ```

2. **Edit for your project:**
   ```bash
   nano .claude-templates.config.json  # or use your editor
   ```

3. **Add to .gitignore** (if it contains sensitive info):
   ```bash
   echo ".claude-templates.config.json" >> .gitignore
   ```
   OR commit it if it's generic team configuration.

---

## Configuration Fields

### Project Information

```json
"project": {
  "name": "your-project-name",           // Used in generated docs and commit messages
  "description": "Brief description",     // Appears in research documents
  "repository": "your-repo-name",         // Used in handoffs and research docs
  "type": "web-app"                       // Options: "web-app", "api", "library", "mobile-app", "pwa"
}
```

**Example:**
```json
"project": {
  "name": "ecommerce-platform",
  "description": "E-commerce platform with React and Node.js",
  "repository": "company/ecommerce-platform",
  "type": "web-app"
}
```

---

### Tech Stack

Defines your project's technology stack for agent recommendations:

```json
"techStack": {
  "languages": ["TypeScript", "JavaScript"],  // Primary languages
  "frontend": ["React", "Vite"],              // Frontend framework/tools
  "backend": ["Node.js", "Express"],          // Backend framework/tools
  "database": ["PostgreSQL", "Redis"],        // Databases
  "testing": ["Vitest", "Playwright"],        // Testing tools
  "other": ["Docker", "AWS"]                  // Other technologies
}
```

**Usage:** Agents will recommend tools and patterns matching your stack.

---

### Package Manager & Commands

Defines commands used by `/validate-fix`, `/ship`, and other commands:

```json
"packageManager": "npm",  // Options: "npm", "pnpm", "yarn", "bun"

"commands": {
  "format": "npm run format",              // Code formatting
  "lint": "npm run lint",                  // Linting
  "lintFix": "npm run lint --fix",        // Auto-fix linting issues
  "typecheck": "tsc --noEmit",            // Type checking
  "test": "npm test",                      // Run tests
  "testCoverage": "npm run test:coverage", // Test coverage
  "build": "npm run build",                // Build command
  "dev": "npm run dev"                     // Development server
}
```

**For Python projects:**
```json
"packageManager": "pip",
"commands": {
  "format": "black .",
  "lint": "ruff check .",
  "lintFix": "ruff check . --fix",
  "typecheck": "mypy .",
  "test": "pytest",
  "testCoverage": "pytest --cov"
}
```

**For Rust projects:**
```json
"packageManager": "cargo",
"commands": {
  "format": "cargo fmt",
  "lint": "cargo clippy",
  "lintFix": "cargo clippy --fix",
  "typecheck": "cargo check",
  "test": "cargo test",
  "build": "cargo build"
}
```

---

### Paths

Defines directory structure for generated files:

```json
"paths": {
  "src": "src",                      // Source code directory
  "components": "src/components",    // Components directory (frontend)
  "tests": "tests",                  // Test directory
  "docs": "docs",                    // Documentation root
  "plans": "docs/plans",             // Implementation plans
  "research": "docs/research",       // Research documents
  "handoffs": "docs/handoffs"        // Handoff documents
}
```

**Commands that use these paths:**
- `/create_plan` → writes to `paths.plans`
- `/research_codebase` → writes to `paths.research`
- `/create_handoff` → writes to `paths.handoffs`
- `/new-component` → creates in `paths.components`

---

### Testing Configuration

Defines testing priorities and coverage goals:

```json
"testing": {
  "criticalPaths": [
    "Authentication flow",           // 100% coverage required
    "Payment processing",
    "Data persistence"
  ],
  "coverage": {
    "critical": 100,                // Critical paths target
    "important": 80,                // Important features target
    "other": 60                     // Other code target
  }
}
```

**Used by:**
- `test-engineer` agent - identifies what to test first
- `/test-coverage` command - evaluates against these goals

---

### Accessibility

Defines accessibility requirements:

```json
"accessibility": {
  "targetAudience": "General public",  // Or "Age 10+", "Enterprise users", etc.
  "wcagLevel": "AA",                   // Options: "A", "AA", "AAA"
  "specialRequirements": [
    "High contrast mode support",
    "Keyboard navigation for all features",
    "Screen reader announcements for dynamic content"
  ]
}
```

**Used by:**
- `accessibility-expert` agent
- `/a11y-audit` command

---

### Deployment

Defines git branching strategy and environments:

```json
"deployment": {
  "mainBranch": "main",                 // Main development branch
  "productionBranch": "production",     // Production branch (or same as main)
  "environments": [
    "development",
    "staging",
    "production"
  ]
}
```

**Used by:**
- `/ship` command - verifies branch before pushing
- Prevents accidental force-push to protected branches

---

### Customization

Enable/disable agents and add custom instructions:

```json
"customization": {
  "enabledAgents": [
    "codebase-analyzer",
    "test-engineer",
    "react-architect"
  ],
  "disabledAgents": [
    "audio-engineer"  // Not relevant for this project
  ],
  "customInstructions": "Always use functional components. Prefer composition over props drilling."
}
```

**Note:** This is for documentation purposes. Agents are enabled by presence in `.claude/agents/` directory.

---

## Example Configurations

### React + TypeScript SPA

```json
{
  "project": {
    "name": "task-manager-app",
    "type": "web-app"
  },
  "techStack": {
    "languages": ["TypeScript"],
    "frontend": ["React", "Vite", "TailwindCSS"],
    "testing": ["Vitest", "Playwright"]
  },
  "packageManager": "pnpm",
  "commands": {
    "format": "pnpm format",
    "lint": "pnpm lint",
    "lintFix": "pnpm lint --fix",
    "typecheck": "pnpm typecheck",
    "test": "pnpm test",
    "build": "pnpm build"
  }
}
```

---

### Python + FastAPI Backend

```json
{
  "project": {
    "name": "api-backend",
    "type": "api"
  },
  "techStack": {
    "languages": ["Python"],
    "backend": ["FastAPI", "SQLAlchemy"],
    "database": ["PostgreSQL", "Redis"],
    "testing": ["pytest", "httpx"]
  },
  "packageManager": "pip",
  "commands": {
    "format": "black . && isort .",
    "lint": "ruff check .",
    "lintFix": "ruff check . --fix",
    "typecheck": "mypy .",
    "test": "pytest",
    "testCoverage": "pytest --cov=app --cov-report=html"
  },
  "paths": {
    "src": "app",
    "tests": "tests"
  }
}
```

---

### Next.js Full-Stack App

```json
{
  "project": {
    "name": "blog-platform",
    "type": "web-app"
  },
  "techStack": {
    "languages": ["TypeScript"],
    "frontend": ["React", "Next.js"],
    "database": ["Prisma", "PostgreSQL"],
    "testing": ["Jest", "Playwright"]
  },
  "packageManager": "npm",
  "commands": {
    "format": "npm run format",
    "lint": "next lint",
    "lintFix": "next lint --fix",
    "typecheck": "tsc --noEmit",
    "test": "jest",
    "build": "next build",
    "dev": "next dev"
  }
}
```

---

### Rust CLI Tool

```json
{
  "project": {
    "name": "cli-tool",
    "type": "library"
  },
  "techStack": {
    "languages": ["Rust"],
    "other": ["clap", "serde"]
  },
  "packageManager": "cargo",
  "commands": {
    "format": "cargo fmt",
    "lint": "cargo clippy -- -D warnings",
    "lintFix": "cargo clippy --fix",
    "typecheck": "cargo check",
    "test": "cargo test",
    "build": "cargo build --release"
  }
}
```

---

## Using Config in Commands

### Example: /validate-fix Command

The `/validate-fix` command reads configuration:

```typescript
// Reads from config.commands
const formatCmd = config.commands.format  // "pnpm format"
const lintCmd = config.commands.lintFix   // "pnpm lint --fix"
const typecheckCmd = config.commands.typecheck
const testCmd = config.commands.test

// Executes:
await run(formatCmd)
await run(lintCmd)
await run(typecheckCmd)
await run(testCmd)
```

### Example: /create_plan Command

```typescript
// Reads from config.paths.plans
const plansDir = config.paths.plans  // "docs/plans"
const planFile = `${plansDir}/${date}-${description}.md`

// Reads from config.project
const projectName = config.project.name
const repoName = config.project.repository
```

---

## .gitignore Recommendations

**If config contains sensitive information** (API keys, internal URLs):
```gitignore
.claude-templates.config.json
```

**If config is generic team configuration** (package manager, paths):
- Commit it to share with team
- Everyone gets same configuration

**Best practice:**
- Keep sensitive info in environment variables
- Commit generic project configuration
- Document required customizations in README

---

## Validation

No validation is currently enforced, but recommended structure:

✅ **Valid:**
```json
{
  "project": { "name": "my-app" },
  "packageManager": "npm"
}
```

❌ **Missing required fields** (will use defaults):
```json
{
  "packageManager": "npm"
  // Missing "project" - may cause issues
}
```

---

## Future Enhancements

Planned features:

- **JSON Schema validation** - Validate config structure
- **Template variables** - Use `{{project.name}}` in agent prompts
- **Environment-specific configs** - `.claude-templates.config.dev.json`, `.claude-templates.config.prod.json`
- **Config merging** - Combine global + project-specific configs
- **CLI tool** - `claude-config validate` to check configuration

---

## Related Documentation

- [README.md](README.md) - Main documentation
- [USAGE_GUIDE.md](USAGE_GUIDE.md) - How to use agents and commands
- [KNOWN_ISSUES.md](KNOWN_ISSUES.md) - Project-specific references to adapt

---

## Questions?

**Q: Do I need this file?**
A: No, it's optional. Commands will use sensible defaults if not present.

**Q: Can I use environment variables?**
A: Not currently, but this is planned for future versions.

**Q: Where should I put this file?**
A: In your project root alongside `.claude/` directory.

**Q: Will agents automatically read this?**
A: Not yet - currently for documentation. Future versions will integrate directly.
