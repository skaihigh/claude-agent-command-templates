# Agents, Commands & Skills Reference

This comprehensive reference guide describes all agents, commands, and skills available in the Claude Code Template Library.

---

## Table of Contents

- [Universal Agents (12)](#universal-agents)
  - [Codebase Analysis](#codebase-analysis-agents)
  - [Research & Testing](#research--testing-agents)
  - [Component Development](#component-development-agents)
  - [Technical Specialists](#technical-specialist-agents)
  - [Visualization](#visualization-agents)
- [Universal Commands (19)](#universal-commands)
  - [Core Workflow](#core-workflow-commands)
  - [Specialized Development](#specialized-development-commands)
- [Universal Skills](#universal-skills)

---

## Universal Agents

### Codebase Analysis Agents

#### 1. Codebase Analyzer
**File:** `.shared/agents/codebase-analyzer.md`
**Model:** Sonnet
**Tools:** Read, Grep, Glob, LS

**Purpose:**
Analyzes codebase implementation details to understand HOW code works. This agent is a documentation specialist that explains existing code with surgical precision.

**Core Capabilities:**
- **Implementation Analysis** - Reads files, identifies key functions, traces method calls and data transformations
- **Data Flow Tracing** - Follows data from entry to exit points, mapping transformations and state changes
- **Pattern Recognition** - Identifies design patterns, architectural decisions, and integration points

**When to Use:**
- Understanding how a specific feature is implemented
- Documenting technical workings with file:line references
- Creating technical documentation of existing systems
- Tracing code paths through the application

**Key Features:**
- ✅ Provides precise file:line references for all claims
- ✅ Structured output format (Overview, Entry Points, Core Implementation, Data Flow, Patterns, Error Handling)
- ⚠️ Documentation ONLY - never suggests improvements or critiques code
- ⚠️ Does NOT perform root cause analysis unless explicitly requested

**Example Use Case:**
```
Question: "How does the webhook validation system work?"
Output: Detailed analysis showing:
- Entry point at api/routes.js:45
- Validation logic at handlers/webhook.js:15-32
- HMAC-SHA256 signature verification
- Timestamp replay attack prevention
- Data flow through services and storage
```

---

#### 2. Codebase Locator
**File:** `.shared/agents/codebase-locator.md`
**Model:** Sonnet
**Tools:** Grep, Glob, LS

**Purpose:**
Finds WHERE code lives in the codebase. Think of it as a "Super Grep/Glob/LS tool" that understands project structure and categorizes findings.

**Core Capabilities:**
- **File Discovery** - Finds files by keywords, directory patterns, and common naming conventions
- **Smart Categorization** - Groups results by purpose (implementation, tests, config, docs, types)
- **Structural Understanding** - Returns organized file lists with full paths and context

**When to Use:**
- Locating all files related to a feature
- Finding test files for a component
- Discovering configuration files
- Understanding codebase organization

**Key Features:**
- ✅ Categorized output: Implementation, Tests, Config, Docs, Types, Examples
- ✅ Provides directory structure with file counts
- ✅ Finds related directories and entry points
- ⚠️ Finds files but does NOT analyze their contents

**Example Output:**
```
Implementation Files:
- src/auth/login.ts
- src/auth/register.ts
- src/auth/middleware.ts

Test Files:
- tests/auth/login.test.ts
- tests/auth/register.test.ts

Configuration:
- config/auth.json
- .env.example (AUTH_SECRET reference)
```

---

#### 3. Codebase Pattern Finder
**File:** `.shared/agents/codebase-pattern-finder.md`
**Model:** Sonnet
**Tools:** Read, Grep, Glob, LS

**Purpose:**
Discovers similar implementations and usage patterns in the codebase. Combines the location abilities of codebase-locator with code analysis to show working examples.

**Core Capabilities:**
- **Pattern Discovery** - Finds comparable features, usage examples, and established patterns
- **Example Extraction** - Provides concrete code snippets with file:line references
- **Convention Documentation** - Shows how the codebase handles similar problems

**When to Use:**
- Finding examples of how to implement a feature
- Discovering existing patterns to follow
- Locating usage examples for APIs or libraries
- Understanding coding conventions

**Key Features:**
- ✅ Shows multiple pattern variations with context
- ✅ Includes working code snippets
- ✅ Documents API patterns, data patterns, component patterns, testing patterns
- ⚠️ Shows patterns without recommending which is "better"

**Example Output:**
```
API Error Handling Patterns:

Pattern 1: Try-Catch with Custom Errors
Location: src/api/users.ts:45-60
try {
  const user = await UserService.create(data)
  return { success: true, data: user }
} catch (error) {
  if (error instanceof ValidationError) {
    return { success: false, error: error.message }
  }
  throw error
}

Pattern 2: Result Type Pattern
Location: src/api/posts.ts:23-35
...
```

---

### Research & Testing Agents

#### 4. Web Search Researcher
**File:** `.shared/agents/web-search-researcher.md`
**Model:** Sonnet
**Tools:** WebSearch, WebFetch

**Purpose:**
Finds current, authoritative information from the web when documentation or best practices are needed beyond the knowledge cutoff.

**Core Capabilities:**
- **Strategic Search** - Analyzes queries to identify key terms and authoritative sources
- **Source Evaluation** - Prioritizes official docs, GitHub repos, and trusted technical sources
- **Content Synthesis** - Extracts relevant information with proper attribution and links

**When to Use:**
- Researching library/framework documentation
- Finding current best practices
- Comparing technology options
- Getting version-specific information
- Understanding breaking changes or migration guides

**Key Features:**
- ✅ Prioritizes official documentation and authoritative sources
- ✅ Provides exact quotes with direct links
- ✅ Notes publication dates and version information
- ✅ Identifies conflicting information or gaps

**Example Use Case:**
```
Query: "How to implement Web Audio API variable speed playback with pitch preservation?"
Process:
1. Searches official MDN Web Audio API docs
2. Finds GitHub discussions and examples
3. Checks Stack Overflow for common issues
4. Synthesizes with attribution and code examples
```

---

#### 5. Test Engineer
**File:** `.shared/agents/test-engineer.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash

**Purpose:**
Comprehensive testing specialist covering unit, integration, E2E, and accessibility testing with focus on behavior-driven development.

**Core Capabilities:**
- **Test Strategy** - Applies testing pyramid/trophy, TDD principles, coverage goals (80%+)
- **Tool Expertise** - Vitest, React Testing Library, Playwright, axe-core, Pa11y, Lighthouse CI
- **Pattern Application** - AAA pattern, testing user behavior, appropriate mocking

**When to Use:**
- Writing comprehensive test suites
- Testing critical application paths
- Implementing accessibility tests
- Creating E2E test scenarios
- Improving test coverage

**Key Features:**
- ✅ Focuses on behavior over implementation
- ✅ Coverage targets: 100% critical paths, 80%+ important features
- ✅ Mock strategies for Audio API, IndexedDB, Service Workers
- ✅ Integration with TypeScript, Vitest, Playwright

**Test Coverage Priorities:**
- **100% Critical:** Core business logic and workflows, data persistence and integrity, external integrations
- **80%+ Important:** UI components, user workflows, error handling
- **As Needed:** Edge cases, browser compatibility

---

### Component Development Agents

#### 6. Storybook Expert
**File:** `.shared/agents/storybook-expert.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash

**Purpose:**
Expert in Storybook component development, documentation, testing, and atomic design composition.

**Core Capabilities:**
- **Storybook Mastery** - CSF 3.0, args composition, play functions, addon integration
- **Framework Support** - React (primary), Vue, Angular, Web Components, Vanilla JS
- **Atomic Design** - Atoms → Molecules → Organisms → Templates → Pages composition

**When to Use:**
- Creating Storybook stories for components
- Auditing codebase for Storybook opportunities
- Building component libraries with documentation
- Implementing interaction tests with play functions

**Key Features:**
- ✅ 6-phase workflow: Analysis → Creation → Testing → Composition → Documentation → Review
- ✅ CSF 3.0 format with TypeScript typing
- ✅ Multiple story variants (minimum 3 per component)
- ✅ Accessibility and interaction testing integration
- ✅ Args composition for reusability

**Example Story Structure:**
```typescript
// ComponentName.stories.tsx
export default {
  title: 'Atoms/Button',
  component: Button,
  argTypes: { onClick: { action: 'clicked' } },
  parameters: {
    a11y: { config: { rules: [{ id: 'color-contrast', enabled: true }] } }
  }
}

export const Default: Story = { args: { children: 'Click me' } }
export const Disabled: Story = { args: { disabled: true } }
export const WithIcon: Story = {
  args: { icon: <Icon /> },
  play: async ({ canvasElement }) => {
    // Interaction tests
  }
}
```

---

### Technical Specialist Agents

#### 7. Accessibility Expert
**File:** `.shared/agents/accessibility-expert.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash

**Purpose:**
WCAG 2.1 AA compliance specialist ensuring applications are usable by all users with varying abilities and age groups.

**Core Capabilities:**
- **WCAG Compliance** - Perceivable, Operable, Understandable, Robust principles
- **Keyboard Navigation** - Tab order, skip links, focus management, keyboard shortcuts
- **Screen Reader Support** - Semantic HTML, ARIA labels, live regions, alternative text
- **Universal Design Principles** - Simple language, large touch targets (44×44px), high contrast

**When to Use:**
- Reviewing components for accessibility
- Implementing ARIA labels and keyboard navigation
- Creating accessible audio/media players
- Ensuring WCAG 2.1 AA compliance
- Optimizing for screen readers

**Key Features:**
- ✅ Comprehensive checklist for audio players, forms, navigation
- ✅ Testing with axe DevTools, Lighthouse, eslint-plugin-jsx-a11y, Pa11y CI
- ✅ Manual testing guidelines (keyboard-only, screen readers, zoom, high contrast)
- ✅ Specific requirements for young users and audio applications

**Accessibility Standards:**
- **Color Contrast:** ≥ 4.5:1 for text, ≥ 3:1 for UI components
- **Touch Targets:** ≥ 44×44px (WCAG AAA), ≥ 24×24px acceptable (WCAG AA)
- **Keyboard Access:** All functionality available via keyboard
- **Screen Reader:** Full compatibility with VoiceOver, NVDA, JAWS

---

#### 8. Audio Engineer
**File:** `.shared/agents/audio-engineer.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash, WebFetch

**Purpose:**
Specialist in advanced audio capabilities for web applications.

**Core Capabilities:**
- **Web Audio API** - Variable speed (0.25x-2.0x) with pitch preservation, buffer management, real-time effects
- **MIDI Processing** - MIDI parsing, soundfont loading, MusicXML conversion, tempo/pitch manipulation
- **PWA Audio Optimization** - Caching strategies, IndexedDB buffer management, background playback, service worker preloading
- **Performance** - Lazy loading, buffer pooling, compression, format optimization (MP3, OGG, AAC)

**When to Use:**
- Implementing variable speed audio playback
- Building audio caching for offline functionality
- Creating waveform visualization
- Developing MIDI playback features
- Optimizing audio performance for mobile

**Key Features:**
- ✅ **CRITICAL:** Pitch preservation during speed changes
- ✅ Mobile browser focus (iOS Safari 14+, Chrome Android 90+)
- ✅ Memory-efficient for long audio files (30+ min sessions)
- ✅ Handles audio interruptions (phone calls, other apps)

**Performance Targets:**
- Low latency for responsive controls
- Smooth seeking without audio glitches
- Memory usage < 100MB for typical sessions
- Works 100% offline after caching

---

#### 9. PWA Specialist
**File:** `.shared/agents/pwa-specialist.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash

**Purpose:**
Expert in Progressive Web Apps, service workers, caching strategies, and offline-first architecture.

**Core Capabilities:**
- **Service Worker Mastery** - Lifecycle management, caching strategies, background sync, update mechanisms
- **Caching Strategies** - Cache-first for static, 7-day cache for audio, network-first for metadata, IndexedDB for user data
- **Storage Management** - IndexedDB schema, transactions, quota management, migration strategies
- **PWA Features** - App manifest, install prompts, offline detection, push notifications, background fetch

**When to Use:**
- Creating offline-first functionality
- Implementing intelligent caching strategies
- Building service worker infrastructure
- Managing storage quotas
- Optimizing PWA performance

**Key Features:**
- ✅ 4-tier caching: Critical assets (forever) → Audio (7-day) → Metadata (1-hour) → User data (IndexedDB)
- ✅ Performance targets: First load <3s on 3G, subsequent <1s, audio playback <500ms
- ✅ Storage management: LRU eviction, 80% quota warnings, user-controlled cache
- ✅ Browser support: iOS Safari 14+, Chrome Android 90+

---

#### 10. React Architect
**File:** `.shared/agents/react-architect.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash

**Purpose:**
Senior React + TypeScript architect specializing in component design, state management, and performance optimization.

**Core Capabilities:**
- **Component Architecture** - Atomic design, composition patterns, compound components, custom hooks
- **State Management** - React Context, TanStack Query, IndexedDB, reducer patterns, optimistic updates
- **Performance** - Code splitting, React.memo, virtual scrolling, debouncing, bundle optimization
- **TypeScript Excellence** - Strict types, generic components, discriminated unions, type guards

**When to Use:**
- Designing component architecture
- Creating custom hooks for shared logic
- Implementing TanStack Query patterns
- Building accessible, responsive components
- Optimizing React performance

**Key Features:**
- ✅ Stack: React 18, TypeScript strict, Vite, shadcn/ui, TanStack Query, CSS Modules
- ✅ Performance targets: FCP <1.5s, TTI <2.5s, Lighthouse 90+, bundle <200KB gzipped
- ✅ Strict component structure: Imports → Types → Component → Hooks → Handlers → Render
- ✅ State strategy: Server state (TanStack Query), Global UI (Context), Local (useState), Persistent (IndexedDB)

---

#### 11. Mobile-First Expert
**File:** `.shared/agents/mobile-first-expert.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash, WebSearch, WebFetch

**Purpose:**
Mobile-first design and UX expert specializing in small-screen optimization, touch interfaces, and mobile utility applications.

**Core Capabilities:**
- **Mobile-First Design** - Content prioritization, performance first, touch-optimized, progressive enhancement
- **Touch Interface Guidelines** - 44×44px minimum targets, 8px spacing, thumb zone optimization, one-handed operation
- **Mobile Typography** - 16-20px body text, 1.5-1.6× line height, WCAG AAA contrast for outdoor use
- **Audio/Music App Expertise** - Audio player controls, waveform visualization, gesture interactions, haptic feedback

**When to Use:**
- Designing mobile-first layouts and navigation
- Optimizing touch targets and gestures
- Creating audio player interfaces for mobile
- Implementing progressive disclosure patterns
- Designing engagement flows (streaks, milestones, reminders)

**Key Features:**
- ✅ Touch target standards: 44×44px (WCAG AAA), 24×24px (WCAG AA)
- ✅ Thumb zone optimization: Natural (bottom) → In-between (middle) → Stretch (top)
- ✅ Core Web Vitals: LCP <2.5s, INP <200ms, CLS <0.1
- ✅ Audio patterns: Bottom controls, waveform scrubbing, A-B loop markers, background audio
- ✅ 489-line comprehensive guide covering viewports, forms, modals, testing, design systems

---

### Visualization Agents

#### 12. Visualization Expert
**File:** `.shared/agents/visualization-expert.md`
**Model:** Sonnet
**Tools:** Read, Write, Edit, Glob, Grep, Bash, WebSearch, WebFetch

**Purpose:**
Expert in creating accessible, insightful visualizations of code architecture, infrastructure, and data flow using diagrams-as-code.

**Core Capabilities:**
- **Diagram-as-Code Tools** - Mermaid (primary), PlantUML, Graphviz, Diagrams Python
- **Accessibility & WCAG** - SVG titles/descriptions, ARIA labels, color contrast, text alternatives
- **Export & Conversion** - mmdc, Pandoc, Inkscape for high-quality PDF/SVG/PNG
- **Integration** - Works with codebase-analyzer, codebase-locator, react-architect, accessibility-expert

**When to Use:**
- Creating system architecture diagrams (C4, deployment, component hierarchy)
- Visualizing data flow (sequence diagrams, flowcharts)
- Documenting state machines, database schemas, API interactions
- Generating accessible documentation with diagrams

**Key Features:**
- ✅ 6-phase workflow: Plan → Gather → Create → Accessibility → Export → Deliver
- ✅ WCAG AA compliant color palette and typography
- ✅ Tool selection matrix for choosing right diagram type
- ✅ Proactively uses helper agents for accurate implementation details
- ✅ Saves Mermaid as `.mmd` extension for version control

**Diagram Types Supported:**
- Flowcharts, Sequence diagrams, Class diagrams, State diagrams
- ER diagrams, Gantt charts, Pie/Bar charts
- Git graphs, User journey maps, C4 architecture diagrams
- Mindmaps, Timelines, Quadrant charts

---

## Universal Commands

### Core Workflow Commands

#### 1. `/commit` - Create Git Commits
**File:** `.shared/commands/commit.md`

**Purpose:**
Create git commits with intelligent grouping and descriptive messages while maintaining user ownership (no Claude attribution).

**Workflow:**
1. Review conversation history, run `git status` and `git diff`
2. Determine if changes should be one or multiple logical commits
3. Draft clear, imperative-mood commit messages
4. Present plan with file lists and messages
5. Upon confirmation, stage specific files and create commits
6. Show results with `git log`

**When to Use:**
When you need to commit changes with well-structured messages without Claude attribution.

**Key Features:**
- ✅ Groups related changes intelligently
- ✅ Uses imperative mood (conventional commits)
- ✅ Never uses `git add -A` or `.` (always specific files)
- ⚠️ No co-author or "Generated with Claude" attribution
- ⚠️ Commits are authored solely by the user

---

#### 2. `/create_handoff` - Create Handoff Document
**File:** `.shared/commands/create_handoff.md`

**Purpose:**
Create concise but thorough handoff document to transfer context to another session.

**Workflow:**
1. Gather metadata (git commit hash, branch, timestamp)
2. Create file: `docs/handoffs/YYYY-MM-DD_HH-MM-SS_description.md`
3. Write with YAML frontmatter and structured sections
4. Include tasks, critical references, recent changes, learnings, artifacts, next steps
5. Present completion message with resume command

**When to Use:**
When pausing work and need to transfer context to a future session seamlessly.

**Key Features:**
- ✅ Includes metadata for traceability
- ✅ Uses file:line references instead of large code blocks
- ✅ Compacts context without losing key details
- ✅ Provides `/resume_handoff` command for continuation

---

#### 3. `/create_plan` - Create Implementation Plans
**File:** `.shared/commands/create_plan.md`
**Model:** Opus

**Purpose:**
Create detailed implementation plans through skeptical, thorough, interactive research and iteration.

**Workflow:**
1. **Context Gathering:** Read all mentioned files fully, spawn research tasks
2. **Research & Discovery:** Use codebase-locator, codebase-analyzer, codebase-pattern-finder
3. **Plan Structure:** Create outline, get user feedback
4. **Detailed Writing:** Write to `docs/plans/YYYY-MM-DD-description.md` with phases and success criteria
5. **Review & Iterate:** Refine based on user feedback

**When to Use:**
When creating a comprehensive implementation plan for complex features or refactoring.

**Key Features:**
- ✅ Uses Opus model for better planning
- ✅ Reads files FULLY before spawning sub-tasks
- ✅ Separates Automated vs Manual success criteria
- ✅ Includes "What We're NOT Doing" section
- ⚠️ No open questions allowed in final plan
- ⚠️ Interactive and iterative process

**Success Criteria Format:**
```markdown
#### Automated Verification:
- [ ] Tests pass: `pytest tests/`
- [ ] Type check: `mypy .`
- [ ] Linting: `ruff check .`

#### Manual Verification:
- [ ] Feature works correctly in UI
- [ ] Performance acceptable with large inputs
- [ ] Error messages clear and helpful
```

---

#### 4. `/implement_plan` - Implement Technical Plans
**File:** `.shared/commands/implement_plan.md`

**Purpose:**
Execute approved implementation plans systematically, following intent while adapting to codebase reality.

**Workflow:**
1. Read plan completely, check for existing checkmarks
2. Read all files mentioned in plan fully
3. Create todo list to track progress
4. Implement each phase fully before moving to next
5. Run success criteria checks after each phase
6. Pause for human verification after automated checks pass
7. Update checkboxes in plan as sections complete

**When to Use:**
When you have an approved plan document and are ready to execute implementation.

**Key Features:**
- ✅ Follows plan intent while adapting to reality
- ✅ Fixes issues before proceeding
- ✅ Pauses for manual verification after each phase
- ✅ Updates plan checkboxes as work completes
- ✅ Can resume from existing checkmarks

---

#### 5. `/research_codebase` - Document Codebase As-Is
**File:** `.shared/commands/research_codebase.md`
**Model:** Opus

**Purpose:**
Conduct comprehensive research to answer questions by documenting what exists, without suggesting improvements.

**Workflow:**
1. Read any directly mentioned files fully
2. Analyze and decompose research question
3. Spawn parallel sub-agents (codebase-locator, codebase-analyzer, codebase-pattern-finder)
4. Wait for all sub-agents, synthesize findings
5. Gather git metadata (commit hash, branch)
6. Generate research document: `docs/research/YYYY-MM-DD-description.md`
7. Add GitHub permalinks if applicable

**When to Use:**
Understanding how something works, documenting architecture, or answering technical questions about existing implementation.

**Key Features:**
- ✅ Uses Opus model for better analysis
- ✅ Documents what IS, not what SHOULD BE
- ✅ Uses specialized agents for different research types
- ✅ Creates permanent research documents with frontmatter
- ⚠️ Does NOT suggest improvements unless explicitly asked

---

#### 6. `/resume_handoff` - Resume From Handoff
**File:** `.shared/commands/resume_handoff.md`

**Purpose:**
Pick up work from a previous session by reading and understanding a handoff document.

**Workflow:**
1. Read handoff document fully
2. Present understanding (task, status, context, next steps)
3. Read all critical reference documents fully
4. Verify current git state matches handoff expectations
5. Proceed with work following handoff's action items
6. Create new handoff when pausing again

**When to Use:**
Starting a new session with a handoff document from a previous session.

**Key Features:**
- ✅ Verifies codebase state matches handoff
- ✅ Warns if state has drifted since handoff creation
- ✅ Respects context and learnings from previous session
- ✅ Always reads documents fully (no limit/offset)

---

#### 7. `/validate_plan` - Validate Implementation Against Plan
**File:** `.shared/commands/validate_plan.md`

**Purpose:**
Ensure implementation correctly followed the plan, verify all success criteria, identify deviations or issues.

**Workflow:**
1. Determine context (existing conversation or fresh start)
2. Locate plan and gather implementation evidence
3. Spawn research tasks to discover implementation if needed
4. Systematically validate each phase
5. Run automated verification commands
6. Generate comprehensive validation report
7. Provide recommendations

**When to Use:**
After implementing a plan, to verify correctness and completeness before merging or shipping.

**Key Features:**
- ✅ Works in existing conversation or fresh start
- ✅ Runs all automated checks (pytest, mypy, ruff)
- ✅ Documents both matches and deviations
- ✅ Identifies potential issues and edge cases
- ✅ Works well after `/commit` and before `/describe_pr`

---

### Specialized Development Commands

#### 8. `/storybook-audit` - Storybook Component Audit
**File:** `.shared/commands/storybook-audit.md`

**Purpose:**
Identify all components needing Storybook stories and create prioritized implementation roadmap.

**Workflow:**
1. Invoke `storybook-expert` agent to analyze codebase
2. Generate analysis report (components without stories, existing stories needing enhancement)
3. Review findings and present to user
4. Ask for confirmation on what to implement
5. Execute based on user choice

**When to Use:**
Understanding Storybook coverage and planning story creation work.

**Key Features:**
- ✅ Atomic design categorization (atom/molecule/organism/template/page)
- ✅ Time estimates for implementation
- ✅ Composition opportunities identification
- ✅ Analysis-first, implementation after approval

---

#### 9. `/create-story` - Create Storybook Story
**File:** `.shared/commands/create-story.md`

**Purpose:**
Generate complete CSF 3.0 story files with accessibility tests, play functions, and proper typing.

**Workflow:**
1. Find component using codebase-locator
2. Analyze props, types, variants, and states
3. Create `.stories.tsx` file with CSF 3.0, args, a11y config, play functions
4. Create test file using `composeStories` if needed
5. Report summary to user

**When to Use:**
Creating comprehensive Storybook story for a specific component with best practices.

**Key Features:**
- ✅ CSF 3.0 format required
- ✅ Minimum 3 story variants
- ✅ Accessibility and interaction testing included
- ✅ Component-specific patterns for atoms/molecules/organisms
- ✅ Creates test file using composeStories

---

#### 10. `/a11y-audit` - Accessibility Audit
**File:** `.shared/commands/a11y-audit.md`

**Purpose:**
Perform thorough accessibility testing and provide actionable recommendations.

**Workflow:**
1. Automated testing (axe-core, ESLint jsx-a11y, Lighthouse)
2. Manual review (keyboard nav, screen reader, color contrast, touch targets)
3. WCAG 2.1 AA compliance check (4 principles)
4. Age-appropriate design review
5. Generate recommendations with severity levels

**When to Use:**
Verifying accessibility compliance for components or pages.

**Key Features:**
- ✅ Uses `@accessibility-expert` agent
- ✅ Provides code fixes for each issue
- ✅ Categorizes by severity (critical, warning, suggestion)
- ✅ WCAG 2.1 AA compliance focused

---

#### 11. `/audio-impl` - Implement Audio Feature
**File:** `.shared/commands/audio-impl.md`

**Purpose:**
Create audio features using Web Audio API with proper mobile support and offline capabilities.

**Workflow:**
1. Delegates to `@audio-engineer` agent
2. Ensures Web Audio API usage
3. Implements offline support with caching
4. Adds comprehensive error handling
5. Includes TypeScript types and unit tests
6. Optimizes for mobile (iOS Safari, Chrome Android)

**When to Use:**
Implementing audio-related features (playback, processing, recording).

**Key Features:**
- ✅ Web Audio API mandatory
- ✅ Mobile optimization required
- ✅ Offline support built-in
- ✅ Refers to PROJECT-VISION.md and TECHNOLOGY.md

---

#### 12. `/docs-audit` - Documentation Audit & Organization
**File:** `.shared/commands/docs-audit.md`

**Purpose:**
Audit all documentation, compare against actual codebase, organize files, track incomplete work.

**Workflow:**
1. **Discovery:** Find all markdown files and categorize
2. **Analyze:** Determine purpose, status, quality issues
3. **Reality Check:** Compare docs vs implementation using codebase-analyzer
4. **Phase Validation:** Check plan/phase files against actual progress
5. **Organization:** Propose file structure reorganization
6. **Link Validation:** Find and fix broken internal links
7. **Generate Report:** Inventory, moves, updates, gaps
8. **Execute Changes:** After confirmation, move files and update links

**When to Use:**
When documentation has become disorganized, outdated, or you need comprehensive view of doc health.

**Key Features:**
- ✅ Compares documentation claims vs actual implementation
- ✅ Identifies incomplete phases and work
- ✅ Proposes organized structure (/architecture, /guides, /specs, /plans, /audits, /reference, /templates)
- ✅ Asks before deleting/moving files
- ✅ Updates all internal links after moves

---

#### 13. `/new-component` - Create New React Component
**File:** `.shared/commands/new-component.md`

**Purpose:**
Generate complete component with all supporting files following best practices.

**Workflow:**
1. Create component structure with proper file organization
2. Implement TypeScript with strict types and props interface
3. Add semantic HTML and accessibility features
4. Create unit tests, integration tests, accessibility tests
5. Generate Storybook stories with variants
6. Add CSS Modules for styling

**When to Use:**
Creating a new React component from scratch with all best practices.

**Key Features:**
- ✅ Uses `@react-architect` and `@accessibility-expert` agents
- ✅ Creates complete file structure (component, tests, stories, styles, types, index)
- ✅ Accessibility mandatory
- ✅ Comprehensive testing included

---

#### 14. `/phase-status` - Check Development Phase Status
**File:** `.shared/commands/phase-status.md`

**Purpose:**
Provide quick status report on current development phase and what comes next.

**Workflow:**
1. Review project's ROADMAP.md
2. Determine current phase (1-8)
3. Show phase progress (completed items)
4. List remaining tasks in current phase
5. Preview next phase
6. Identify blockers

**When to Use:**
When you want a quick status update on project progress and next steps.

**Key Features:**
- ✅ Simple, focused command
- ✅ Clear status report with checkboxes
- ✅ Shows blockers and technical decisions needed

---

#### 15. `/pwa-check` - PWA Configuration Audit
**File:** `.shared/commands/pwa-check.md`

**Purpose:**
Perform comprehensive PWA audit covering service worker, offline functionality, performance, and manifest.

**Workflow:**
1. Check service worker status, caching strategies, cache versioning
2. Test offline mode support, IndexedDB schema, data persistence
3. Analyze bundle sizes, cache hit rates, loading performance
4. Verify manifest.json configuration, icons, theme colors
5. Run Lighthouse PWA audit if possible
6. Provide recommendations

**When to Use:**
Validating PWA implementation or troubleshooting offline functionality.

**Key Features:**
- ✅ Uses `@pwa-specialist` agent
- ✅ Comprehensive coverage of PWA requirements
- ✅ Includes performance analysis
- ✅ Provides actionable recommendations

---

#### 16. `/research-tech` - Research Technology Option
**File:** `.shared/commands/research-tech.md`

**Purpose:**
Perform comprehensive technology evaluation against project-specific criteria.

**Workflow:**
1. Technology overview (what it is, current version, popularity)
2. Project fit analysis (compatibility with stack, bundle size, browser support)
3. Evaluation against criteria (Performance, DX, Maintenance, Compatibility, Cost)
4. Compare alternatives (2-3 alternatives with pros/cons)
5. Implementation plan (installation, configuration, integration)
6. Clear decision (Adopt ✅ / Evaluate ⚠️ / Reject ❌)

**When to Use:**
Evaluating a new library, framework, or technology for adoption in the project.

**Key Features:**
- ✅ Uses WebFetch for external research
- ✅ Evaluates against TECHNOLOGY.md criteria
- ✅ Provides bundle size impact
- ✅ Browser support emphasis (iOS Safari, Chrome Android)
- ✅ Outputs structured research document

---

#### 17. `/test-coverage` - Analyze Test Coverage
**File:** `.shared/commands/test-coverage.md`

**Purpose:**
Identify gaps in test coverage and prioritize test creation.

**Workflow:**
1. Check current coverage (existing tests, coverage reports, untested paths)
2. Identify critical paths (audio playback, save points, offline sync, auth)
3. List missing tests (components without tests, untested edge cases, error scenarios)
4. Review test quality (AAA pattern, implementation details, mocks, readability)
5. Provide recommendations with priority

**When to Use:**
Assessing test coverage quality and identifying what tests need to be written.

**Key Features:**
- ✅ Uses `@test-engineer` agent
- ✅ Prioritizes by importance
- ✅ Reviews test quality, not just coverage percentage
- ✅ Actionable recommendations

---

#### 18. `/validate-fix` - Validate and Auto-Fix Code Quality
**File:** `.shared/commands/validate-fix.md`

**Purpose:**
Ensure code quality by running formatting, linting, type checking, and tests with automatic fixes.

**Workflow:**
1. Format code (Prettier)
2. Lint and auto-fix (ESLint with --fix)
3. Type check (TypeScript compiler)
4. Run tests (test suite)
5. Fix any remaining issues manually
6. Report summary

**When to Use:**
Before committing code or as part of ship process to ensure all quality checks pass.

**Key Features:**
- ✅ Fixes auto-fixable issues automatically
- ✅ Manually fixes type errors and test failures
- ✅ Asks user for guidance on complex issues
- ✅ Tracks progress with TodoWrite

---

#### 19. `/ship` - Validate, Commit, and Push
**File:** `.shared/commands/ship.md`

**Purpose:**
Complete git workflow automation from validation through push with intelligent commit grouping.

**Workflow:**
1. **Pre-flight:** Verify branch safety, check for conflicts
2. **Validation:** Use `/validate-fix` to ensure quality
3. **Analyze changes:** Group files into logical chunks
4. **Create commits:** Stage and commit each chunk with conventional commit messages
5. **Review summary:** Show user all commits and changes
6. **Push:** After confirmation, push to remote branch

**When to Use:**
When you're ready to ship changes and want intelligent commit grouping with full validation.

**Key Features:**
- ✅ Conventional commit format (type(scope): description)
- ✅ Groups changes logically (i18n, features, fixes, docs, tests)
- ✅ Never pushes to main/master without approval
- ✅ Warns about secrets/credentials
- ✅ Shows summary before pushing

---

## Universal Skills

Currently, the `.shared/skills/` directory is prepared for future skill modules. Skills are reusable bundles of capabilities that can be invoked by agents.

**Planned Skills:**
- Audio processing workflows
- PWA setup and configuration
- Component library scaffolding
- Test suite generation
- Documentation generation

Skills will be added in future phases as common workflows are identified and standardized.

---

## Summary Statistics

### Agents: 12 Total
- **Codebase Analysis:** 3 (analyzer, locator, pattern-finder)
- **Research & Testing:** 2 (web-search-researcher, test-engineer)
- **Component Development:** 1 (storybook-expert)
- **Technical Specialists:** 5 (accessibility-expert, audio-engineer, pwa-specialist, react-architect, mobile-first-expert)
- **Visualization:** 1 (visualization-expert)

### Commands: 19 Total
- **Core Workflow:** 7 (commit, create_handoff, create_plan, implement_plan, research_codebase, resume_handoff, validate_plan)
- **Specialized Development:** 12 (storybook-audit, create-story, a11y-audit, audio-impl, docs-audit, new-component, phase-status, pwa-check, research-tech, test-coverage, validate-fix, ship)

### Skills: 0 (Planned for future phases)

---

## Agent Integration Patterns

Many agents are designed to work together:

**Planning Workflow:**
```
/create_plan
  → Uses: codebase-locator, codebase-analyzer, codebase-pattern-finder
  → Output: Implementation plan
  → Next: /implement_plan
```

**Storybook Workflow:**
```
/storybook-audit
  → Uses: storybook-expert, codebase-locator
  → Output: Component analysis
  → Next: /create-story (for each component)
```

**Quality Assurance Workflow:**
```
/validate-fix
  → Runs: Prettier, ESLint, TypeScript, Tests
  → Next: /commit
  → Final: /ship
```

**Research Workflow:**
```
/research_codebase
  → Uses: codebase-analyzer, codebase-locator, codebase-pattern-finder
  → Output: Research document
  → Next: /create_plan (if implementation needed)
```

---

## Next Steps

For detailed setup instructions, see [README.md](README.md).

For cross-platform usage with other AI coding assistants, see [CROSS_PLATFORM_USAGE.md](CROSS_PLATFORM_USAGE.md).
