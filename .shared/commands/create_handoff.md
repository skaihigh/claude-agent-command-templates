---
description: Create handoff document for transferring work to another session
---

# Create Handoff

You are tasked with writing a handoff document to hand off your work to another agent in a new session. You will create a handoff document that is thorough, but also **concise**. The goal is to compact and summarize your context without losing any of the key details of what you're working on.

## Process

### 1. Filepath & Metadata

Use the following information to understand how to create your document:
- Create your file under `docs/handoffs/YYYY-MM-DD_HH-MM-SS_description.md`, where:
  - YYYY-MM-DD is today's date
  - HH-MM-SS is the hours, minutes and seconds based on the current time, in 24-hour format (i.e. use `13:00` for `1:00 pm`)
  - description is a brief kebab-case description
- Gather metadata:
  ```bash
  git rev-parse HEAD  # Get commit hash
  git branch --show-current  # Get branch name
  date -u +"%Y-%m-%dT%H:%M:%S%z"  # Get current date/time
  ```
- Examples:
  - `2025-11-12_13-55-22_add-memory-agent.md`
  - `2025-11-12_09-30-15_fix-routing-bug.md`

### 2. Handoff Writing

Using the above conventions, write your document. Use the defined filepath, and the following YAML frontmatter pattern. Use the metadata gathered in step 1, Structure the document with YAML frontmatter followed by content:

Use the following template structure:

```markdown
---
date: [Current date and time in ISO format]
author: Claude
git_commit: [Current commit hash]
branch: [Current branch name]
repository: langChain_and_subAgents
topic: "[Feature/Task Name]"
tags: [handoff, relevant-component-names]
status: in_progress
last_updated: [Current date in YYYY-MM-DD format]
last_updated_by: Claude
type: handoff
---

# Handoff: {very concise description}

**Date**: [Current date and time]
**Branch**: `[branch name]`
**Commit**: `[commit hash]`

## Task(s)
{description of the task(s) that you were working on, along with the status of each (completed, work in progress, planned/discussed). If you are working on an implementation plan, make sure to call out which phase you are on. Make sure to reference the plan document and/or research document(s) you are working from that were provided to you at the beginning of the session, if applicable.}

## Critical References
{List any critical specification documents, architectural decisions, or design docs that must be followed. Include only 2-3 most important file paths. Leave blank if none.}

## Recent Changes
{describe recent changes made to the codebase that you made in [file:line](file#Lline) syntax}

## Learnings
{describe important things that you learned - e.g. patterns, root causes of bugs, or other important pieces of information someone that is picking up your work after you should know. Consider listing explicit file paths.}

## Artifacts
{an exhaustive list of artifacts you produced or updated as filepaths and/or file:line references - e.g. paths to plans, research documents, code files, etc that should be read in order to resume your work.}

## Action Items & Next Steps
{a list of action items and next steps for the next agent to accomplish based on your tasks and their statuses}

## Other Notes
{other notes, references, or useful information - e.g. where relevant sections of the codebase are, where relevant documents are, or other important things you learned that you want to pass on but that don't fall into the above categories}
```

### 3. Present Completion

Once the document is written, respond to the user with:

```
Handoff created! You can resume from this handoff in a new session with the following command:

/resume_handoff docs/handoffs/YYYY-MM-DD_HH-MM-SS_description.md
```

For example:

```
Handoff created! You can resume from this handoff in a new session with the following command:

/resume_handoff docs/handoffs/2025-11-12_13-44-55_add-memory-agent.md
```

## Additional Notes & Instructions

- **More information, not less**. This is a guideline that defines the minimum of what a handoff should be. Always feel free to include more information if necessary.
- **Be thorough and precise**. Include both top-level objectives, and lower-level details as necessary.
- **Avoid excessive code snippets**. While a brief snippet to describe some key change is important, avoid large code blocks or diffs; do not include one unless it's necessary (e.g. pertains to an error you're debugging). Prefer using `path/to/file.py:line` references that an agent can follow later when it's ready, e.g. [agents.py:123-145](agents.py#L123-L145)
- **Context compaction**. Compress your current context into essential information without losing key details - the goal is to enable another agent to pick up where you left off efficiently.
