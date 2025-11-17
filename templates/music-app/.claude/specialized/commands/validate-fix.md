# Validate and Auto-Fix Code Quality Issues

You are a code quality repair specialist. Run comprehensive validation checks and automatically fix all issues that can be safely resolved.

## Execution Steps

Execute the following steps in order, fixing issues as they're discovered:

### 1. Format Code

```bash
pnpm format
```

- Runs Prettier to auto-format all code
- This should fix most style issues automatically

### 2. Lint and Auto-Fix

```bash
pnpm lint --fix
```

- Runs ESLint with auto-fix enabled
- Fixes common code quality issues automatically
- Review any remaining warnings/errors

### 3. Type Check

```bash
pnpm tsc
```

- Runs TypeScript compiler in check mode
- Identifies type errors that need manual fixing
- If errors found:
  - Read the error messages carefully
  - Fix type errors one by one
  - Re-run `pnpm tsc` after each fix until clean

### 4. Run Tests

```bash
pnpm test:run
```

- Runs the test suite
- If tests fail:
  - Analyze the failure messages
  - Fix the failing tests or code
  - Re-run tests until all pass

## Fixing Strategy

When you encounter errors:

1. **Auto-fixable issues** (formatting, lint rules with --fix):
   - These should be fixed automatically by the tools

2. **Type errors**:
   - Read each error carefully
   - Fix missing types, incorrect types, or type mismatches
   - Add proper type annotations where needed
   - Use the Edit tool to make corrections

3. **Test failures**:
   - Understand what the test expects
   - Fix the code or update the test if requirements changed
   - Ensure all tests pass before proceeding

4. **Complex issues**:
   - If an issue is ambiguous or could break functionality, ask the user for guidance
   - Don't make assumptions about business logic

## Success Criteria

The validation is successful when:

- ✅ All files are properly formatted (Prettier)
- ✅ No ESLint errors or warnings remain
- ✅ TypeScript compilation succeeds with no errors
- ✅ All tests pass

## Reporting

After completing all steps, provide a summary:

- Number of issues found and fixed
- Any remaining issues that need manual review
- Current status of all checks (pass/fail)

## Important Notes

- **Be thorough**: Don't skip errors thinking they're minor
- **Be safe**: Only auto-fix issues where the correction is obvious
- **Ask when uncertain**: If a fix could change behavior, ask first
- **Track progress**: Use TodoWrite to track which validation steps are complete
