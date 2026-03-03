---
name: database-schema-troubleshooting
description: Auto-activated skill for debugging database schema changes, sync failures, and Firestore issues
activate-keywords:
  - sync fail
  - schema chang
  - new collection
  - firestore
  - collection not found
  - cannot write to production
  - export fail
  - import fail
  - firestore rules
  - service account
  - pii sanitization
  - data validation
activate-patterns:
  - '\b(schema|collection|firestore|sync)\b.*\b(fail|error|issue|problem|not work)\b'
  - '\b(add|create|remove|delete)\s+(collection|field|document)\b'
  - '\bfirestore\.rules\b'
  - '\b(pii|gdpr|sanitize)\b.*\b(data|export)\b'
---

# Database Schema Troubleshooting Skill

Auto-activated when discussing database schema changes, sync failures, or Firestore operations.

## Activation Triggers

This skill auto-activates when your message contains keywords like:

- Schema changes: "schema change", "new collection", "add field"
- Sync issues: "sync fail", "export fail", "import fail"
- Firestore problems: "firestore error", "collection not found", "rules issue"
- Data safety: "pii sanitization", "gdpr", "data validation"
- Service account: "service account", "credentials", "permission denied"

## Your Automated Actions

When activated, you will automatically:

1. **Diagnose the Issue**
   - Identify if it's a schema, sync, or permissions problem
   - Check recent changes that might have caused it
   - Review relevant logs and error messages

2. **Provide Procedure**
   - Step-by-step solution based on the problem type
   - Safety checks to prevent data loss
   - Rollback procedures if needed

3. **Suggest Prevention**
   - Best practices to avoid the issue in future
   - Validation steps before deploying changes
   - Testing strategies

4. **Reference Documentation**
   - Link to `scripts/README-SYNC.md` schema change section
   - Point to relevant source files
   - Suggest related agents for complex issues

## Problem Categories You Handle

### Category 1: Schema Addition Issues
```
"I want to add a 'difficulty' field to songs"

Auto-response includes:
✓ Check if collection exists in firestore.rules
✓ Verify TypeScript types are updated
✓ Explain backwards compatibility
✓ Provide deployment order (code → rules → sync)
✓ Show test procedure
```

### Category 2: Sync Failures
```
"Export failed: Collection not accessible"

Auto-response includes:
✓ Check if collection was just created in production
✓ Verify firestore.rules are deployed
✓ Check service account permissions
✓ Show diagnostic command: pnpm sync:dry-run
✓ Suggest logs inspection: logs/sync-*.log
```

### Category 3: Permissions Issues
```
"Import failed: Permission denied"

Auto-response includes:
✓ Verify correct service account for environment
✓ Check firestore.rules deployment to dev project
✓ Suggest checking Firebase Console for errors
✓ Provide firestore.rules validation steps
```

### Category 4: Data Validation
```
"How do we ensure data integrity after sync?"

Auto-response includes:
✓ Document count validation query
✓ PII sanitization verification steps
✓ ID mapping integrity checks
✓ Nullish field validation for old documents
```

## Integration with Database Change Advisor

For complex scenarios, this skill will suggest:

```
This looks like a complex schema issue. Use @database-change-advisor
for detailed guidance on: [specific aspect]
```

## Quick Reference for Common Issues

| Issue | First Step | Resolution |
|-------|-----------|-----------|
| "Collection not accessible" during export | Check if collection exists in production | Create collection in production console |
| "Permission denied" during import | Verify service account | Check firestore.rules deployment |
| "Field doesn't exist" in old documents | This is expected | Handle with nullish coalescing (??) in code |
| "Sync takes too long" | Check --max-age parameter | Use `pnpm sync:prod-to-dev --max-age=7` |

## Safety Guardrails

This skill will WARN if it detects:

- Attempting to write changes to production service account ⚠️
- Deleting collections without approval ⚠️
- Missing firestore.rules deployment ⚠️
- PII in exported data ⚠️
- Backwards-incompatible schema changes ⚠️

---

**Always active when discussing databases, schemas, or sync operations.**
