# VSSK-shadecn Claude Code Ecosystem

This directory contains the complete Claude Code configuration for VSSK-shadecn, providing specialized AI assistance for development.

## Directory Structure

```
.claude/
├── agents/                    # Specialized sub-agents
│   ├── audio-engineer.md      # Web Audio API, pitch preservation, MIDI
│   ├── pwa-specialist.md      # Service workers, caching, offline functionality
│   ├── react-architect.md     # Component design, state management, performance
│   ├── accessibility-expert.md # WCAG compliance, keyboard nav, ARIA
│   └── test-engineer.md       # Testing strategy, coverage, mocks
├── commands/                  # Custom slash commands
│   ├── phase-status.md        # Check development phase progress
│   ├── audio-impl.md          # Implement audio features
│   ├── new-component.md       # Create component with tests/stories
│   ├── pwa-check.md           # Audit PWA functionality
│   ├── a11y-audit.md          # Accessibility audit
│   ├── test-coverage.md       # Analyze test coverage
│   └── research-tech.md       # Research technology options
├── skills/                    # Auto-invoked skills
│   ├── audio-debugging/       # Automatic audio issue debugging
│   └── pwa-troubleshooting/   # Automatic PWA issue troubleshooting
├── QUICK-REFERENCE.md         # Quick reference cheat sheet
└── README.md                  # This file
```

## Quick Start

### Using Sub-Agents

Sub-agents are specialized experts. Invoke with `@`:

```bash
@audio-engineer Implement variable speed playback
@pwa-specialist Setup service worker caching
@react-architect Design AudioPlayer component
@accessibility-expert Review for WCAG compliance
@test-engineer Create test suite
```

### Using Slash Commands

Custom workflows tailored to the project. Invoke with `/`:

```bash
/phase-status              # Check current phase
/new-component Button      # Create complete component
/audio-impl speed control  # Implement audio feature
/a11y-audit AudioPlayer    # Accessibility audit
/pwa-check                 # PWA audit
/test-coverage src/        # Test coverage analysis
/research-tech Tone.js     # Research technology
```

### Skills (Auto-Activate)

Skills activate automatically based on your query:

- **audio-debugging**: Mention audio playback issues
- **pwa-troubleshooting**: Mention service worker or offline problems

Just describe your problem naturally, and the skill will activate if relevant.

## Configuration Files

- **`.mcp.json`** (project root): MCP server configuration
- **`agents/*.md`**: Sub-agent definitions with expertise and constraints
- **`commands/*.md`**: Slash command implementations
- **`skills/*/SKILL.md`**: Auto-invoked skill definitions

## MCP Servers

Configured in `../.mcp.json`:

- ✅ **memory**: Active - Persistent context and decisions
- ⏸️ **figma**: Disabled until Phase 4 - Design-to-code workflow
- ⏸️ **postgres**: Disabled until Phase 7 - Database access

## Documentation

- **[CLAUDE-CODE-SETUP.md](../docs/CLAUDE-CODE-SETUP.md)**: Complete guide with examples
- **[QUICK-REFERENCE.md](QUICK-REFERENCE.md)**: Cheat sheet for quick lookup

## Tips

1. **Be Specific**: Provide context, requirements, and constraints
2. **Combine Tools**: Use multiple sub-agents for comprehensive reviews
3. **Let Skills Activate**: Describe problems naturally; skills auto-invoke
4. **Check Phase Status**: Run `/phase-status` to understand current work

## Examples

### Create New Feature
```bash
# 1. Check where we are
/phase-status

# 2. Research if needed
/research-tech library-name

# 3. Create component
/new-component FeatureName

# 4. Implement with specialist
@react-architect @audio-engineer
Implement [feature] with these requirements...

# 5. Verify quality
/test-coverage FeatureName
/a11y-audit FeatureName
```

### Debug Issue
```bash
# Automatic (skill activates)
"The audio won't play in Safari"

# Explicit (sub-agent)
@audio-engineer
Debug: Audio playback fails in iOS Safari with error...
```

### Code Review
```bash
@react-architect @accessibility-expert @test-engineer
Review src/components/AudioPlayer/ for:
- Architecture and performance
- Accessibility compliance
- Test coverage
```

## Modifying the Ecosystem

### Adding a New Sub-Agent

1. Create `.claude/agents/new-agent.md`
2. Add YAML frontmatter:
   ```yaml
   ---
   name: new-agent
   description: What this agent does and when to use it
   allowed-tools: [Read, Write, Edit, Glob, Grep, Bash]
   ---
   ```
3. Write expertise and guidelines
4. Restart Claude Code
5. Test with `@new-agent`

### Adding a Slash Command

1. Create `.claude/commands/new-command.md`
2. Add frontmatter:
   ```yaml
   ---
   description: What this command does
   ---
   ```
3. Write command prompt
4. Optionally delegate to sub-agents with `@agent-name`
5. Test with `/new-command`

### Adding a Skill

1. Create `.claude/skills/new-skill/SKILL.md`
2. Add frontmatter with descriptive keywords:
   ```yaml
   ---
   name: new-skill
   description: Activates when user mentions [specific keywords or scenarios]
   ---
   ```
3. Write diagnostic and solution steps
4. Test by mentioning relevant keywords

## Project Structure

The codebase follows a modular, feature-based architecture with **Atomic Design** principles:

```
src/
├── components/        # Shared UI components
│   ├── atoms/         # Smallest units (Badge, Icon, Spinner) ✨ NEW
│   ├── molecules/     # Simple compositions (SearchBar, FormField) ✨ NEW
│   ├── organisms/     # Complex sections (PlayerControls, SongList) ✨ NEW
│   ├── templates/     # Page layouts (LibraryTemplate, PlayerTemplate) ✨ NEW
│   ├── layouts/       # Root layouts (RootLayout, etc.)
│   ├── shared/        # Cross-feature components (ProtectedRoute, AppSidebar)
│   └── ui/            # shadcn/ui components (Button, Card, etc.)
├── features/          # Feature modules
│   ├── admin/         # Admin section (songs, profiles, settings, uploads)
│   ├── auth/          # Authentication (login, signup, password reset)
│   ├── library/       # Song library (SongCard, SongFilters, LibraryPage)
│   ├── player/        # Audio player (AudioPlayer, LoopSection, SavePoints)
│   ├── profiles/      # Music profiles (composers, arrangers, artists)
│   └── settings/      # User settings (CacheManagementPage)
├── hooks/             # Custom React hooks
│   ├── useProfiles.ts          # Fetch music profiles
│   ├── useSongMutations.ts     # Song CRUD mutations (NEW)
│   ├── useLastSession.ts       # Session persistence
│   └── use-toast.ts            # Toast notifications
├── services/          # Business logic & external integrations
│   ├── authService.ts          # Firebase authentication
│   ├── songService.ts          # Song CRUD operations
│   ├── profileService.ts       # Music profile management
│   ├── practiceTracking.ts     # Practice session analytics
│   ├── cacheService.ts         # PWA caching strategies
│   └── audioEngine.ts          # Web Audio API wrapper
├── utils/             # Shared utility functions (NEW ✨)
│   ├── formatters.ts           # Time, bytes, offset formatting
│   ├── math.ts                 # Clamp, percentages, rounding
│   ├── firebase.ts             # Error handling, sanitization
│   ├── search.ts               # Filtering, normalization
│   ├── sort.ts                 # Array sorting utilities
│   ├── dom.ts                  # DOM helpers, clipboard
│   └── index.ts                # Barrel export
├── config/            # App configuration
│   ├── firebase.ts             # Firebase initialization
│   └── navigation.tsx          # Route definitions
├── data/              # Static data & constants
│   ├── songs.ts                # Song catalog
│   ├── instruments.ts          # Instrument definitions
│   └── songDurations.ts        # Song duration mappings
├── i18n/              # Internationalization
│   └── locales/                # Translation files (en-GB, nb-NO, pl-PL)
├── types/             # TypeScript type definitions
│   ├── index.ts                # Core types (Song, SavePoint, Loop)
│   ├── firebase.ts             # Firebase-specific types
│   └── musicProfile.ts         # Music profile types
└── routes/            # React Router routes
```

### Recent Improvements

**✨ Atomic Design Architecture (2025-11-14)**
- Implemented Atomic Design methodology for component organization
- Created 4 new component folders: atoms/, molecules/, organisms/, templates/
- Set up comprehensive README guides for each atomic level
- Integrated Storybook 8.6.14 for component documentation and testing
- See [docs/ATOMIC_DESIGN_IMPLEMENTATION_PLAN.md](../docs/ATOMIC_DESIGN_IMPLEMENTATION_PLAN.md) for the plan
- See [docs/ATOMIC_DESIGN_WORKFLOW.md](../docs/ATOMIC_DESIGN_WORKFLOW.md) for daily workflow

**✨ Utils Consolidation (2025-11-14)**
- Created centralized `src/utils/` module with 29 reusable functions
- Eliminated 30+ duplicate implementations across the codebase
- Improved maintainability with single source of truth
- See [docs/UTILS_MIGRATION_GUIDE.md](../docs/UTILS_MIGRATION_GUIDE.md) for details

**🎯 Custom Hooks**
- Extracted mutation logic into `useSongMutations` hook
- Standardized error handling and toast notifications
- Reduced component complexity by ~20%

**📦 Key Modules**
- **components/atoms/**: Basic building blocks (Button, Badge, Icon, Spinner)
- **components/molecules/**: Simple compositions (SearchBar, FormField, SongCard)
- **components/organisms/**: Complex sections (PlayerControls, NavigationHeader)
- **components/templates/**: Page layouts (LibraryTemplate, PlayerTemplate)
- **features/**: Feature-based organization with co-located components, hooks, and tests
- **services/**: Business logic separated from UI components
- **utils/**: Pure functions for formatting, math, search, sort, DOM operations
- **hooks/**: Reusable stateful logic with React Query integration

**🎨 Storybook Integration**
- Component documentation with interactive controls
- Accessibility testing with @storybook/addon-a11y
- Visual regression testing support
- Run with: `pnpm storybook`

## Troubleshooting

### Sub-Agent Not Found
- Check file exists in `.claude/agents/`
- Verify YAML frontmatter is valid
- Restart Claude Code

### Command Not Listed
- Run `/help` to see all commands
- Check `.claude/commands/` for typos
- Verify frontmatter has `description`

### Skill Not Activating
- Make `description` more specific with keywords
- Mention problem explicitly
- Use sub-agent directly as fallback

### MCP Connection Failed
- Check `.mcp.json` syntax
- Verify MCP server installed
- Check environment variables
- Restart Claude Code

---

**Need Help?** See [docs/CLAUDE-CODE-SETUP.md](../docs/CLAUDE-CODE-SETUP.md) for comprehensive documentation.
