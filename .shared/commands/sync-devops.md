---
description: Azure DevOps Work Item Sync
  Triggers: "sync devops", "update work items", "devops sync"
---

# Azure DevOps Work Item Sync

Synchronize Azure DevOps work items with actual git commits. This command analyzes recent commits, correlates them with work items, and proposes updates.

## Configuration

- **Project**: Portal
- **Project ID**: b14f2444-570c-46e4-8715-7d732b8d4deb
- **Parent Feature**: #8201 (Rewrite to React)

## Instructions

You are an Azure DevOps sync agent. Your job is to keep work items in sync with actual development work.

### Phase 1: Gather Information

1. **Get recent commits** since the last sync (or last 20 commits if first run):
   ```bash
   git log --oneline -20 --since="1 week ago"
   git log --oneline -20  # fallback if no recent commits
   ```

2. **Fetch open work items** from Azure DevOps:
   - Use `mcp__azure-devops__wit_my_work_items` with project "Portal"
   - Use `mcp__azure-devops__search_workitem` to find items related to "React", "rewrite", "migration"
   - Get child items of Feature #8201 using `mcp__azure-devops__wit_get_work_item` with expand "relations"

3. **Fetch current iteration** to assign new items:
   - Use `mcp__azure-devops__work_list_iterations` for project "Portal"

### Phase 2: Analyze and Correlate

For each commit, determine:
1. **Direct references**: Look for `#1234` patterns in commit messages
2. **Keyword matching**: Match commit descriptions to work item titles/descriptions
3. **Category detection**: Classify commits as:
   - `fix:` → Bug fix
   - `feat:` → User Story or Task
   - `refactor:` → Task
   - `docs:` → Task (Documentation)
   - `test:` → Task (Testing)
   - `style:` → Task (Code quality)

### Phase 3: Generate Sync Report

Create a structured report with:

#### A. Work Items to UPDATE (status/comments)
For items that have related commits:
- Current state → Proposed state
- Comments to add documenting the work

#### B. Work Items to CLOSE
Items where all acceptance criteria appear met based on commits

#### C. Work Items to SPLIT
Items that are mostly done but have remaining work:
- Original item → Close with summary
- New item → Remaining work description

#### D. NEW Work Items to CREATE
Commits that don't map to existing items:
- Group related commits into logical work items
- Suggest parent (Feature #8201 for React work)
- Suggest type (Task, Bug, User Story)

### Phase 4: Present for Approval

Display the sync report in this format:

```
## Azure DevOps Sync Report

### Updates (X items)
| ID | Title | Current State | → New State | Action |
|----|-------|---------------|-------------|--------|
| #1234 | Fix booking form | New | Active | Add comment about commits |

### Closures (X items)
| ID | Title | Reason |
|----|-------|--------|
| #1235 | Add date filters | All commits merged, feature complete |

### Splits (X items)
| Original | Close With | New Item |
|----------|------------|----------|
| #1236 | "Core logic complete" | "Remaining: Add unit tests" |

### New Items (X items)
| Type | Title | Parent | Related Commits |
|------|-------|--------|-----------------|
| Task | Fix user photo 404 error | #8201 | d1ada43, 3bcc330 |

---
Proceed with sync? (yes/no/modify)
```

### Phase 5: Execute Sync (after approval)

Only after user confirms:

1. **Update items**: Use `mcp__azure-devops__wit_update_work_item`
   - Update state: `/fields/System.State`
   - Add comments: Use `mcp__azure-devops__wit_add_work_item_comment`

2. **Close items**: Update state to "Closed" or "Done"

3. **Create new items**: Use `mcp__azure-devops__wit_create_work_item`
   - Set iteration path
   - Link to parent feature
   - Add description with commit references

4. **Link commits to items**: Use `mcp__azure-devops__wit_add_artifact_link` where applicable

### State Mapping

Azure DevOps states for this project:
- **New** → Item created, not started
- **Active** → Work in progress
- **Resolved** → Work complete, pending review
- **Closed** → Done and verified

### Commit-to-State Logic

| Commit Pattern | Work Item Action |
|----------------|------------------|
| Commit mentions item ID | Set to Active, add comment |
| PR merged with item | Set to Resolved |
| Feature complete (all commits) | Propose Close |
| Partial work done | Keep Active, update description |

### Safety Rules

1. **Never auto-close** without user approval
2. **Never delete** work items
3. **Always show diff** before making changes
4. **Preserve existing** comments and history
5. **Link, don't duplicate** - prefer linking commits to creating new items

## Example Session

```
User: /sync-devops

Agent: Analyzing commits and work items...

Found:
- 9 new commits since last sync
- 12 open work items in Portal project
- 5 items under Feature #8201

Correlations:
- Commit d1ada43 "fix: Return 404 for missing photos" → No matching item
- Commit 3bcc330 "fix: Resolve export conflicts" → Matches #8245 (partial)
- Commit 2a23fd1 "docs: Add migration status" → No matching item

[Displays sync report table]

Proceed with sync? (yes/no/modify)

User: yes

Agent: Executing sync...
✓ Created Task #8301: "Fix user photo 404 error handling"
✓ Updated #8245: Added comment, state → Active
✓ Created Task #8302: "Document migration status"

Sync complete! 2 items created, 1 item updated.
```

## Run this command

Execute the sync process now. Start with Phase 1 to gather information.
