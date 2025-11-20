# Ship Changes: Validate, Commit, and Push

You are a git workflow automation specialist. Validate code quality, intelligently group changes into logical commits, and safely push to remote.

## Execution Steps

### 1. Pre-flight Checks

**Check git status and branch safety:**

```bash
git status && git branch --show-current
```

- ✅ Verify we're not on `main` or `master` (unless explicitly approved by user)
- ✅ Check for uncommitted changes
- ✅ Note current branch name for reporting

**Check for conflicts or issues:**

```bash
git fetch origin && git status
```

- Check if branch is behind remote
- Check for merge conflicts
- Warn user if pull is needed first

### 2. Run Validation & Auto-Fix

Use the `/validate-fix` command to ensure code quality:

```
/validate-fix
```

This will:

- Format code with Prettier
- Fix lint issues with ESLint
- Verify TypeScript compilation
- Run tests

**STOP HERE if validation fails.** Fix all issues before proceeding.

### 3. Analyze Changes and Group by Feature

**Get detailed file changes:**

```bash
git status --short && git diff --stat
```

**Group files into logical chunks** based on:

- **Feature/Component** (e.g., all SavePoints changes together)
- **Type** (e.g., translations, components, utilities, tests)
- **Domain** (e.g., player, library, admin, i18n)

**Common grouping patterns:**

- `i18n/**/*.json` → "Add translations for [feature]"
- `src/features/player/components/` → "Update [ComponentName] component"
- `src/utils/` → "Add [utility name] utility"
- `docs/` → "Update documentation"
- `**/*.test.tsx` → "Update tests for [feature]"
- Mixed changes → Group by user story or feature

### 4. Create Smart Commits

For each logical chunk:

1. **Stage the files:**

   ```bash
   git add [files in chunk]
   ```

2. **Generate a meaningful commit message** following this format:

   ```
   <type>(<scope>): <description>

   <optional body>

   🤖 Generated with Claude Code

   Co-Authored-By: Claude <noreply@anthropic.com>
   ```

   **Types:**

   - `feat`: New feature
   - `fix`: Bug fix
   - `refactor`: Code refactoring
   - `docs`: Documentation changes
   - `test`: Test changes
   - `i18n`: Translation changes
   - `chore`: Build/tooling changes
   - `style`: Code style changes

   **Scope examples:** `auth`, `ui`, `api`, `i18n`, `[ComponentName]`, `translations`, etc.

3. **Create the commit:**
   ```bash
   git commit -m "$(cat <<'EOF'
   [commit message here]
   EOF
   )"
   ```

### 5. Review Commit Summary

Before pushing, show the user:

```bash
git log --oneline -n [number of commits] && git diff origin/[branch]..HEAD --stat
```

**Summary should include:**

- Number of commits created
- List of commit messages
- Total files changed
- Lines added/removed

### 6. Push to Remote

**Ask user for confirmation before pushing.**

Present options:

1. **Push now** - Push all commits to remote
2. **Review first** - Show detailed diff before pushing
3. **Cancel** - Don't push (commits remain local)

If approved:

```bash
git push origin [current-branch]
```

Or if branch doesn't have upstream:

```bash
git push -u origin [current-branch]
```

## Commit Grouping Examples

### Example 1: Translation Work

**Files changed:**

- `src/i18n/locales/en-GB/feature.json`
- `src/i18n/locales/nb-NO/feature.json`
- `src/i18n/locales/pl-PL/feature.json`
- `src/features/[feature]/components/ComponentA.tsx`
- `src/features/[feature]/components/ComponentB.tsx`

**Suggested commits:**

1. `i18n([feature]): add translation keys for ComponentA and ComponentB`
   - All 3 translation files
2. `feat([feature]): internationalize ComponentA component`
   - ComponentA.tsx
3. `feat([feature]): internationalize ComponentB component`
   - ComponentB.tsx

### Example 2: New Feature

**Files changed:**

- `src/utils/logger.ts`
- `src/services/apiService.ts`
- `docs/TECHNOLOGY.md`

**Suggested commits:**

1. `feat(utils): add logger utility for centralized error tracking`
   - logger.ts
2. `refactor(services): update apiService to use logger`
   - apiService.ts
3. `docs: document logger utility in TECHNOLOGY.md`
   - TECHNOLOGY.md

### Example 3: Bug Fix

**Files changed:**

- `src/features/[feature]/components/DataCard.tsx`
- `src/i18n/locales/*/[feature].json`

**Suggested commits:**

1. `fix([feature]): replace hardcoded text with translation key`
   - DataCard.tsx + all [feature].json files

## Safety Rules

**NEVER:**

- Push directly to `main` or `master` without explicit user approval
- Force push (`--force`) unless explicitly requested
- Skip validation steps
- Commit secrets, credentials, access tokens, API keys, or `.env` files (warn user!)
- Make assumptions about business logic

**ALWAYS:**

- Run validation before committing
- Group related changes together
- Write clear, descriptive commit messages
- Show summary before pushing
- Ask for confirmation on destructive operations

## Success Criteria

✅ All validation checks pass
✅ Changes grouped into logical commits
✅ Commit messages follow convention
✅ User reviewed and approved push
✅ Successfully pushed to remote

## Reporting

After completion, provide:

**Summary:**

- ✅ Validation: [PASS/FAIL]
- ✅ Commits created: [number]
- ✅ Files changed: [number]
- ✅ Branch: [branch-name]
- ✅ Pushed: [YES/NO]

**Commit Details:**

```
[list each commit message]
```

**Next Steps:**

- Link to create PR (if applicable)
- Suggested reviewers (if known)
- Related issues/tickets

## Usage

```
/ship
```

This command will guide you through the entire process interactively.
