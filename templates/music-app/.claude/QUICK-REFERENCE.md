# Claude Code Quick Reference

> Quick reference for VSSK-shadecn Claude Code ecosystem

## Sub-Agents (Use @ to invoke)

| Agent | Use For | Example |
|-------|---------|---------|
| `@audio-engineer` | Audio features, Web Audio API | `@audio-engineer Implement pitch preservation` |
| `@pwa-specialist` | Service workers, caching, offline | `@pwa-specialist Setup audio caching strategy` |
| `@react-architect` | Components, state, performance | `@react-architect Design AudioPlayer architecture` |
| `@accessibility-expert` | WCAG, keyboard nav, ARIA | `@accessibility-expert Review AudioPlayer a11y` |
| `@test-engineer` | Testing, coverage, mocks | `@test-engineer Write tests for save points` |

## Slash Commands (Use / to invoke)

| Command | Purpose | Example |
|---------|---------|---------|
| `/phase-status` | Check development phase progress | `/phase-status` |
| `/audio-impl <feature>` | Implement audio feature | `/audio-impl variable speed playback` |
| `/new-component <name>` | Create component with tests | `/new-component AudioPlayer` |
| `/pwa-check` | Audit PWA functionality | `/pwa-check` |
| `/a11y-audit <target>` | Accessibility audit | `/a11y-audit src/components/AudioPlayer` |
| `/test-coverage <target>` | Test coverage analysis | `/test-coverage AudioPlayer` |
| `/research-tech <name>` | Research technology | `/research-tech Tone.js` |

## Skills (Auto-activate based on context)

| Skill | Activates For |
|-------|---------------|
| `audio-debugging` | Audio playback issues, Web Audio API errors |
| `pwa-troubleshooting` | Service worker issues, offline problems, cache issues |

## MCP Servers

| MCP | Status | Use |
|-----|--------|-----|
| `memory` | ✅ Active | Persistent context and decisions |
| `figma` | ⏸️ Phase 4 | Design-to-code workflow |
| `postgres` | ⏸️ Phase 7 | Database access |

## Common Workflows

### Create New Feature
```
1. /phase-status
2. /new-component FeatureName
3. @react-architect Implement feature logic
4. /test-coverage FeatureName
5. /a11y-audit FeatureName
```

### Debug Audio Issue
```
"The audio won't play in Safari"
[audio-debugging skill auto-activates]

Or explicitly: @audio-engineer Debug Safari audio issue
```

### PWA Optimization
```
1. /pwa-check
2. @pwa-specialist Optimize caching strategy
3. @react-architect Optimize bundle size
```

## Tips

- **Multiple agents:** `@react-architect @accessibility-expert Create accessible AudioPlayer`
- **Specific requests:** Include requirements, constraints, and context
- **Skills activate automatically:** Just describe your problem naturally
- **Commands delegate:** `/audio-impl` automatically uses `@audio-engineer`

## Help

- `/help` - List all available commands
- `/agents` - List all sub-agents
- See [CLAUDE-CODE-SETUP.md](../docs/CLAUDE-CODE-SETUP.md) for full documentation
