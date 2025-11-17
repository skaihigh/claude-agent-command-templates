---
description: Research codebase to deeply understand implementation before making changes
model: opus
---

# Research Codebase

You are tasked with researching a codebase to understand how specific features or components work. This research will inform future implementation plans.

## Initial Response

When this command is invoked:

1. **Parse the input to identify**:
   - What feature/component/area to research
   - What specific questions need answering
   - What level of detail is needed

2. **Handle different input scenarios**:

   **If NO topic provided**:
   ```
   I'll help you research the codebase. What would you like to understand?

   For example:
   - "How does audio playback work?"
   - "How is user authentication implemented?"
   - "How are practice sessions saved?"
   - "What's the component structure for the player?"
   ```
   Wait for user input.

   **If topic provided**:
   - Proceed immediately to Step 1
   - No preliminary questions needed

## Process Steps

### Step 1: Understand the Scope

1. **Clarify the research goal**:
   - What decision will this research inform?
   - What level of detail is needed?
   - Are there specific questions to answer?

2. **Identify likely areas**:
   - Which directories would contain this code?
   - What naming patterns to look for?
   - What related features might be relevant?

### Step 2: Spawn Parallel Research Tasks

**Always use sub-agents for research to keep context clean.**

Create a research plan with parallel tasks:

1. **Create a research todo list** using TodoWrite

2. **Spawn parallel sub-tasks**:
   Use the right agent for each type of research:

   **For finding files:**
   ```
   Task: codebase-locator
   Prompt: Find all files related to [feature]. Look in src/features/, src/components/, src/hooks/, src/lib/. Include implementation files, tests, types, and configuration.
   ```

   **For understanding implementation:**
   ```
   Task: codebase-analyzer
   Prompt: Analyze how [feature] works. Start with [main file], trace the data flow, document key functions with file:line references. Explain the implementation approach.
   ```

   **For finding patterns:**
   ```
   Task: codebase-locator
   Prompt: Find similar patterns to [pattern] in the codebase. Look for other uses of [technology/approach] to understand conventions.
   ```

3. **Be specific about scope**:
   - Include directory paths in prompts
   - Specify what information to extract
   - Request file:line references
   - Define expected output format

4. **Wait for ALL sub-tasks to complete** before proceeding

### Step 3: Synthesize Findings

After all research tasks complete:

1. **Read key files into main context**:
   - Read the most important files fully
   - Focus on files that answer core questions
   - Don't read everything - be selective

2. **Cross-reference findings**:
   - Verify sub-agent findings are consistent
   - Identify gaps or contradictions
   - Note areas needing deeper investigation

3. **If gaps remain**:
   - Spawn follow-up research tasks
   - Read additional files
   - Don't guess - get actual evidence

### Step 4: Document Research Findings

Create a research document in `docs/research/[date]-[topic].md`:

```markdown
# Research: [Topic]

**Date**: YYYY-MM-DD
**Research Goal**: [What decision will this inform?]
**Researched By**: Claude (codebase-analyzer, codebase-locator agents)

## Summary

[2-3 paragraph overview of findings]

## Key Findings

### 1. [Finding Category]

**What exists**: [Describe what's implemented]

**How it works**: [Explain the mechanism]

**Key files**:
- `src/path/to/file.ts:123` - [What this file does]
- `src/path/to/other.tsx:45` - [What this file does]

**Patterns observed**:
- [Pattern 1 with example]
- [Pattern 2 with example]

### 2. [Another Finding Category]

[Same structure as above]

## Technical Details

### Architecture

[Describe the architectural approach]

### Data Flow

```
1. Entry point: src/path/file.ts:123
2. Processing: src/path/other.ts:45
3. State update: src/path/state.ts:67
4. UI render: src/path/Component.tsx:89
```

### Dependencies

- **External**: [List npm packages used]
- **Internal**: [List internal modules depended upon]

### Configuration

- [Config file 1]: [What it configures]
- [Config file 2]: [What it configures]

## Questions Answered

**Q: [Original question 1]?**
A: [Answer with file:line references]

**Q: [Original question 2]?**
A: [Answer with file:line references]

## Open Questions

- [ ] [Question that needs more investigation]
- [ ] [Another unanswered question]

## Recommendations for Implementation

[If this research was to inform implementation]

Based on this research, future implementation should:
1. [Recommendation based on existing patterns]
2. [Recommendation based on architecture]
3. [Recommendation based on conventions]

## Related Documentation

- [Link to related research doc]
- [Link to related plan]
```

### Step 5: Present Findings

Present a concise summary to the user:

```
I've completed the codebase research for [topic].

## Key Findings:
- [Finding 1]
- [Finding 2]
- [Finding 3]

## Files Analyzed:
- [Important file 1]
- [Important file 2]

Full research documented in: `docs/research/[date]-[topic].md`

Would you like me to:
1. Dive deeper into any specific area?
2. Create an implementation plan based on this research?
3. Research related areas?
```

## Important Guidelines

1. **Use Sub-Agents Aggressively**:
   - Don't do research in main context
   - Spawn parallel tasks for efficiency
   - Use specialized agents for their strengths
   - Wait for completion before synthesizing

2. **Be Thorough**:
   - Don't skip test files - they show usage patterns
   - Check configuration files
   - Look at related features
   - Find all entry points

3. **Be Precise**:
   - Always include file:line references
   - Quote actual code when relevant
   - Verify claims by reading files
   - Don't make assumptions

4. **Document Well**:
   - Create persistent research documents
   - Use consistent markdown format
   - Make it easy to reference later
   - Include metadata (date, goal, agents used)

5. **Separate Facts from Recommendations**:
   - First section: What exists (pure documentation)
   - Last section: What to do (recommendations)
   - Keep them clearly separated

6. **Track Progress**:
   - Use TodoWrite to track research tasks
   - Update todos as sub-agents complete
   - Mark complete when documented

## Research Document Naming

Use consistent naming: `docs/research/YYYY-MM-DD-[topic-slug].md`

Examples:
- `docs/research/2025-01-15-audio-playback.md`
- `docs/research/2025-01-15-authentication-flow.md`
- `docs/research/2025-01-15-state-management.md`

## Sub-task Spawning Best Practices

When spawning research sub-tasks:

1. **Spawn in parallel** - Don't do one at a time
2. **Be specific** - Include directories, expected output
3. **Use right agent** - locator for WHERE, analyzer for HOW
4. **Request format** - Tell agents what format you want back
5. **Verify results** - If something seems off, spawn follow-up
6. **Read selectively** - Bring only key files into main context

## Example Interaction Flows

**Scenario 1: Feature research**
```
User: /research_codebase How does audio playback work?
Assistant: [Spawns codebase-locator and codebase-analyzer in parallel]
Assistant: [Waits for completion, reads key files]
Assistant: [Documents findings in docs/research/2025-01-15-audio-playback.md]
Assistant: [Presents summary to user]
```

**Scenario 2: No topic provided**
```
User: /research_codebase
Assistant: What would you like to understand? [Examples...]
User: How are practice sessions saved?
Assistant: [Proceeds with research]
```

## Success Criteria

Research is complete when:
- [ ] All key files identified and analyzed
- [ ] Data flow documented with file:line references
- [ ] Patterns and conventions identified
- [ ] Original questions answered
- [ ] Research document created
- [ ] Findings presented to user

Remember: Good research leads to better plans, which lead to better implementations. Take the time to understand deeply before proposing changes.
