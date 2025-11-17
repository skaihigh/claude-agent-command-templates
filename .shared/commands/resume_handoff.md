---
description: Resume work from a handoff document
---

# Resume Handoff

You are tasked with resuming work from a handoff document created by a previous session.

## Process

### 1. Read the Handoff Document

When this command is invoked with a handoff file path:

1. **Read the handoff document FULLY**:
   - Read the entire file without limit/offset parameters
   - Pay attention to the YAML frontmatter metadata
   - Understand the current task status

2. **Present your understanding**:
   ```
   I've read the handoff document. Here's my understanding:

   **Task**: [Brief description from handoff]
   **Status**: [Current status of the work]
   **Branch**: `[branch from metadata]`
   **Last Commit**: `[commit hash]`

   **Key Context**:
   - [Important point 1]
   - [Important point 2]
   - [Important point 3]

   **Next Steps**: [Action items from handoff]

   Would you like me to:
   1. Continue with the next steps as outlined?
   2. Review the critical references first?
   3. Verify the current state of the code?
   ```

### 2. Read Critical References

After user confirmation:

1. **Read all critical reference documents FULLY**:
   - Implementation plans mentioned in the handoff
   - Research documents referenced
   - Any specification documents listed

2. **Read key code files mentioned in Recent Changes and Learnings**:
   - Files with recent modifications
   - Files mentioned as important patterns
   - Files in the "Other Notes" section

### 3. Verify Current State

Before proceeding:

1. **Check git status**:
   ```bash
   git status
   git log -1  # Check latest commit
   git diff  # Check for uncommitted changes
   ```

2. **Verify expected state**:
   - Cross-reference handoff's git_commit with current state
   - Check if any files mentioned in "Recent Changes" have been modified since
   - Identify any drift from the handoff state

3. **Present verification results**:
   ```
   **Current State Verification**:
   - Branch: `[current branch]`
   - Latest commit: `[commit hash]` [matches/doesn't match handoff]
   - Uncommitted changes: [yes/no, list if any]

   [If state doesn't match]:
   ⚠️  Warning: The codebase state has changed since the handoff was created.
   Changes detected: [list of differences]

   Should I:
   1. Proceed anyway
   2. Review the changes first
   3. Create a new handoff to document the current state
   ```

### 4. Proceed with Work

Once verified:

1. **Follow the action items** listed in the handoff
2. **Apply the learnings** mentioned in the handoff
3. **Reference the critical documents** as needed
4. **Continue from the phase/step** indicated in the Task(s) section

### 5. Update or Create New Handoff

When pausing work again:

- If making significant progress, create a new handoff to document the updated state
- Use `/create_handoff` command to capture the current context

## Important Notes

- **Read everything FULLY**: Don't skim the handoff or referenced documents
- **Verify state**: Always check that the codebase matches the handoff's expectations
- **Ask questions**: If anything in the handoff is unclear, ask the user before proceeding
- **Respect the context**: The handoff contains compressed wisdom from the previous session
- **Follow the plan**: If a plan is referenced, read it fully and follow its approach
- **Update as you go**: Keep track of progress and be ready to create a new handoff

## Example Usage

```bash
# Resume from a specific handoff
/resume_handoff docs/handoffs/2025-11-12_13-44-55_add-memory-agent.md

# After resuming, when you need to pause again
/create_handoff
```
