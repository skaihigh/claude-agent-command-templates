---
description: Create detailed implementation plans with research and iteration
model: opus
---

# Create Implementation Plan

You are tasked with creating a comprehensive implementation plan for a feature or change. This plan will be used by execution agents to implement the work in phases.

## Initial Response

When this command is invoked:

1. **Parse the input to identify**:
   - What needs to be implemented
   - Any specific requirements or constraints
   - Whether research has already been done

2. **Handle different input scenarios**:

   **If NO feature/task described**:
   ```
   I'll help you create an implementation plan. What feature or change would you like to plan?

   For example:
   - "Add user authentication"
   - "Implement audio loop section feature"
   - "Optimize player performance"
   - "Add practice session statistics"
   ```
   Wait for user input.

   **If feature described but seems complex**:
   ```
   I understand you want to implement [feature].

   Before creating the plan, I should research the codebase to understand:
   - [Key area 1]
   - [Key area 2]
   - [Key area 3]

   Would you like me to run `/research_codebase` first, or do you have existing research I should review?
   ```

   **If feature described and straightforward**:
   - Proceed immediately to research step

## Process Steps

### Step 0: Research (If Needed)

**If the feature is complex or unfamiliar:**

1. **Identify what needs research**:
   - Existing related code
   - Patterns used in similar features
   - Dependencies and integrations

2. **Option A - Run research**:
   ```
   Let me research the codebase first to inform the plan.
   [Spawn research tasks with codebase-locator and codebase-analyzer]
   [Document findings]
   ```

3. **Option B - Use existing research**:
   ```
   I see there's existing research at docs/research/[file].md
   [Read and incorporate findings]
   ```

### Step 1: Read Context

1. **Read all relevant existing code**:
   - Use Read tool WITHOUT limit/offset (read files completely)
   - Read related features for patterns
   - Read test files to understand expected behavior
   - Read configuration files

2. **Understand the broader context**:
   - How does this fit into existing architecture?
   - What conventions should be followed?
   - What dependencies exist?

3. **Read any existing research documents** in docs/research/

### Step 2: Draft Initial Plan

Create a structured plan with the following sections:

```markdown
# Implementation Plan: [Feature Name]

**Created**: YYYY-MM-DD
**Status**: Draft

## Goal

[1-2 sentence description of what we're building and why]

## Context

[2-3 paragraphs explaining:
- What currently exists
- Why this change is needed
- How it fits into the broader system]

## Research Summary

[Brief summary of research findings that informed this plan]
[Link to research doc if exists: docs/research/YYYY-MM-DD-topic.md]

## Scope

### What We're Doing
- [Specific deliverable 1]
- [Specific deliverable 2]
- [Specific deliverable 3]

### What We're NOT Doing
- [Out of scope item 1]
- [Out of scope item 2]

## Implementation Approach

[Describe the overall technical approach]
[Explain key decisions and trade-offs]
[Note any patterns being followed from existing code]

## Phases

### Phase 1: [Phase Name]

**Goal**: [What this phase achieves]

**Changes**:
- [ ] `src/path/file.ts:123` - [Specific change description]
- [ ] `src/path/other.tsx:45` - [Specific change description]
- [ ] Create `src/path/new-file.ts` - [What this file will contain]

**Success Criteria**:

*Automated Verification*:
- [ ] `pnpm type-check` passes
- [ ] `pnpm lint` passes
- [ ] `pnpm test` passes
- [ ] Specific test: [test name] verifies [behavior]

*Manual Verification*:
- [ ] [Specific UI behavior to test]
- [ ] [Another manual test step]

### Phase 2: [Phase Name]

[Same structure as Phase 1]

### Phase 3: [Phase Name]

[Same structure as Phase 1]

## Testing Strategy

### Unit Tests
- [Test file 1] - [What it tests]
- [Test file 2] - [What it tests]

### Integration Tests
- [Test scenario 1]
- [Test scenario 2]

### Manual Testing
- [Manual test scenario 1]
- [Manual test scenario 2]

## Risks and Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk 1] | [High/Med/Low] | [How to address] |
| [Risk 2] | [High/Med/Low] | [How to address] |

## Dependencies

### External
- [npm package] - [Why needed]

### Internal
- [File/module] - [How it's used]

## Rollback Plan

[How to undo this change if needed]

## Follow-up Work

[Future enhancements or related work not in this plan]
```

### Step 3: Present Plan for Iteration

**CRITICAL**: Plans should be iterated 5+ times before implementation.

Present the draft plan:

```
I've created a draft implementation plan for [feature].

## Overview:
[Brief summary]

## Phases:
1. Phase 1: [Name] - [Brief description]
2. Phase 2: [Name] - [Brief description]
3. Phase 3: [Name] - [Brief description]

## Key Decisions:
- [Decision 1 and rationale]
- [Decision 2 and rationale]

Draft saved to: `docs/plans/YYYY-MM-DD-feature-name.md`

This is iteration 1 of the plan. Let's refine it together. What would you like to adjust?

Consider:
- Are the phases broken down appropriately?
- Are the success criteria clear and measurable?
- Are there edge cases we should address?
- Should scope be adjusted?
```

### Step 4: Iterate Based on Feedback

**For each round of feedback:**

1. **Listen carefully** to the user's concerns or suggestions
2. **Research if needed** - spawn sub-tasks to investigate concerns
3. **Update the plan** with Edit tool (surgical changes)
4. **Present changes clearly**:
   ```
   Updated the plan (Iteration [N]):

   Changes made:
   - [Change 1]
   - [Change 2]

   Rationale:
   - [Why these changes]

   The plan now addresses:
   - [Improvement 1]
   - [Improvement 2]

   What else should we refine?
   ```

5. **Continue until user approves** or requests implementation

### Step 5: Finalize Plan

When the plan is approved:

1. **Update status to "Ready"**:
   ```markdown
   **Status**: Ready for Implementation
   ```

2. **Add final metadata**:
   ```markdown
   **Iterations**: [N]
   **Approved**: YYYY-MM-DD
   ```

3. **Present completion**:
   ```
   Implementation plan finalized after [N] iterations.

   Saved to: `docs/plans/YYYY-MM-DD-feature-name.md`

   Next steps:
   - Run `/implement_plan docs/plans/YYYY-MM-DD-feature-name.md` to execute
   - Or start implementation manually using this as a guide

   Ready to proceed?
   ```

## Important Guidelines

1. **Research First**:
   - Don't plan in a vacuum
   - Read existing code to understand patterns
   - Use research findings to inform technical decisions

2. **Be Specific**:
   - Include file:line references for changes
   - Make success criteria measurable
   - Use concrete examples

3. **Iterate Aggressively**:
   - Expect 5+ iterations
   - Ask probing questions
   - Challenge assumptions
   - Refine based on feedback

4. **Think in Phases**:
   - Each phase should be independently verifiable
   - Early phases should build foundation for later ones
   - Phases should be small enough to complete in one session

5. **Separate Automated vs Manual**:
   - Automated: Can be run by commands (pnpm test, pnpm build, etc.)
   - Manual: Requires human judgment (UI testing, UX validation)

6. **No Open Questions**:
   - If something is unclear, research it NOW
   - Don't leave "TBD" or "need to investigate" in final plan
   - Every detail should be specified

7. **Track Progress**:
   - Use TodoWrite if planning is complex
   - Track research tasks
   - Track iteration improvements

## Plan Naming Convention

Use consistent naming: `docs/plans/YYYY-MM-DD-[feature-slug].md`

Examples:
- `docs/plans/2025-01-15-audio-loop-section.md`
- `docs/plans/2025-01-15-user-authentication.md`
- `docs/plans/2025-01-15-performance-optimization.md`

## Success Criteria Guidelines

**Automated Verification** should be:
- Commands that can be run: `pnpm test`, `pnpm lint`, `pnpm type-check`, `pnpm build`
- Specific files that should exist
- Code compilation/type checking
- Automated tests passing

**Manual Verification** should be:
- UI/UX functionality requiring human judgment
- Performance under real conditions
- Edge cases that are hard to automate
- User acceptance criteria

## Sub-task Spawning Best Practices

When spawning research sub-tasks during planning:

1. **Only spawn if truly needed** - don't research for simple features
2. **Spawn multiple tasks in parallel** for efficiency
3. **Each task should be focused** on a specific area
4. **Provide detailed instructions** including:
   - Exactly what to search for
   - Which directories to focus on
   - What information to extract
   - Expected output format
5. **Request specific file:line references** in responses
6. **Wait for all tasks to complete** before synthesizing
7. **Verify sub-task results** - if something seems off, spawn follow-up tasks

## Example Interaction Flows

**Scenario 1: Simple feature, no research needed**
```
User: /create_plan Add a mute button to the audio player
Assistant: [Reads AudioPlayer component and hook]
Assistant: [Creates initial plan]
Assistant: [Iterates 5+ times with user]
Assistant: [Finalizes plan]
```

**Scenario 2: Complex feature, needs research**
```
User: /create_plan Add practice session analytics dashboard
Assistant: This is complex. Let me research how sessions are stored...
Assistant: [Spawns codebase-locator and codebase-analyzer]
Assistant: [Creates plan based on findings]
Assistant: [Iterates with user]
Assistant: [Finalizes plan]
```

**Scenario 3: Research already exists**
```
User: /create_plan Implement the audio lazy loading from docs/research/2025-01-15-performance.md
Assistant: [Reads research doc]
Assistant: [Creates plan based on research]
Assistant: [Iterates with user]
Assistant: [Finalizes plan]
```

## Validation Checklist

Before finalizing, ensure:
- [ ] All phases have clear goals
- [ ] All changes have file:line references (or specify "Create new file")
- [ ] Success criteria are measurable
- [ ] Automated and manual verification separated
- [ ] No open questions or TBDs
- [ ] Risks identified with mitigations
- [ ] Testing strategy defined
- [ ] Dependencies documented
- [ ] Plan has been iterated 5+ times

Remember: A good plan makes implementation straightforward. Take the time to research, iterate, and refine until the path forward is crystal clear.
