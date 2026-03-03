---
name: diagnostics
description: Run TypeScript and ESLint checks to show all code diagnostics
triggers:
  - diagnostics
  - check diagnostics
  - show problems
  - code problems
  - type errors
  - lint errors
---

# Diagnostics Skill

Run comprehensive code diagnostics since VSCode Problems panel is not accessible to Claude Code.

## What This Skill Does

When invoked, immediately run these commands and report results:

1. **TypeScript Check**
   ```bash
   pnpm tsc --noEmit 2>&1
   ```

2. **ESLint Check**
   ```bash
   pnpm lint 2>&1
   ```

3. **Summary Report**
   - Count of TypeScript errors
   - Count of ESLint errors/warnings
   - List of affected files
   - Suggested fixes if applicable

## Output Format

```
## Diagnostics Report

### TypeScript (tsc --noEmit)
✅ No errors | ❌ X errors found

[errors listed here if any]

### ESLint
✅ No errors | ❌ X errors, Y warnings

[issues listed here if any]

### Summary
- Total issues: X
- Files affected: Y
- Recommended action: [fix/ignore/investigate]
```

## When to Use

- At the start of a session to understand codebase health
- After making changes to verify no regressions
- When user mentions "problems", "errors", or "diagnostics"
- Before committing code

## Execution

Run both checks in parallel for speed, then combine results into a clear report.
