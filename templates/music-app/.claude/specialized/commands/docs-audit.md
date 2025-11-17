# Documentation Audit & Organization

You are a documentation organization specialist. Perform a comprehensive audit of all markdown documentation, compare it against actual codebase implementation, organize files appropriately, and track incomplete work.

## Execution Steps

### 1. Discovery Phase - Find All Documentation

**Scan for all markdown files:**

```bash
find . -type f -name "*.md" -not -path "*/node_modules/*" -not -path "*/.git/*" | sort
```

**Categorize files by location:**
- Root level (README.md, etc.)
- `/docs/` folder
- `/docs/plans/` (if exists)
- `/.claude/commands/` (command documentation)
- Other locations

### 2. Analyze Current Documentation Structure

For each markdown file found, determine:

1. **Purpose/Category:**
   - Architecture/Design (TECHNOLOGY.md, ICON_SYSTEM.md)
   - Guides/How-tos (MCP_SETUP.md, RBAC_GUIDE.md)
   - Specifications/Plans (feature specs, phase plans)
   - Audits/Reports (TRANSLATION_AUDIT.md, COLLABORATIVE_ANNOTATIONS_ANALYSIS.md)
   - Reference (API docs, configuration templates)
   - Templates (MCP_CONFIG_TEMPLATE.md)
   - Temporary/Scratch (forslag2.png references, etc.)

2. **Current Status:**
   - ✅ Up-to-date and accurate
   - ⚠️ Partially outdated (some sections need updates)
   - ❌ Completely outdated
   - 🗑️ Should be deleted (duplicate, irrelevant)
   - 📦 Should be archived
   - 📝 Needs creation (referenced but doesn't exist)

3. **Documentation Quality Issues:**
   - Broken internal links
   - References to non-existent files
   - Outdated code examples
   - Missing sections
   - Duplicate content
   - Orphaned (not referenced anywhere)

### 3. Codebase Reality Check

Use the **codebase-analyzer agent** to:

```
Analyze the actual implementation of features mentioned in [specific doc file].
Compare the documented architecture/features with what's actually implemented.
Identify:
1. Features documented but not implemented
2. Features implemented but not documented
3. Implementation details that differ from documentation
4. Outdated technology choices that have been replaced
```

**Key files to check against codebase:**
- `TECHNOLOGY.md` vs `package.json` dependencies
- Phase/plan documents vs actual feature implementation
- Architecture docs vs actual code structure
- Setup guides vs actual configuration

### 4. Phase & Plan Validation

Check specific plan/phase files like:
- `PHASES.md`
- `ROADMAP.md`
- Any files in `/docs/plans/`

Use `/validate_plan` command if needed for detailed phase analysis.

**Extract for each plan:**
- Current phase/status claims
- Completed items
- Incomplete items
- Blocked items
- Items marked as "TODO" or "pending"

**Compare against actual codebase:**
- What's actually implemented
- What's partially implemented
- What hasn't been started
- What's been implemented but not in the plan

### 5. Documentation Organization Plan

Based on analysis, categorize all docs into target locations:

**Proposed structure:**
```
/docs/
  /architecture/     - TECHNOLOGY.md, system design
  /guides/          - MCP_SETUP.md, how-to guides
  /specs/           - Feature specifications
  /plans/           - Phase plans, roadmaps
  /audits/          - Audit reports (translation, a11y, etc.)
  /reference/       - ICON_SYSTEM.md, RBAC_GUIDE.md
  /templates/       - MCP_CONFIG_TEMPLATE.md
  README.md         - Documentation map/index
```

**For each file, determine:**
- Current location
- Recommended location
- Reason for move (or keep in place)
- Any files that reference it (will need link updates)

### 6. Link Validation & Updates

**Find all internal links:**
```bash
grep -r "\[.*\](\..*\.md)" docs/
grep -r "\[.*\](\.\..*\.md)" docs/
```

**For files being moved:**
1. Identify all files that link to it
2. Calculate new relative paths
3. Update all references

**Check for broken links:**
- Links to files that don't exist
- Links with incorrect relative paths
- Links to moved/deleted files

### 7. Generate Comprehensive Report

Create a detailed markdown report with:

#### A. Documentation Inventory

```markdown
## Documentation Inventory

### Root Level
- [ ] README.md - Up-to-date ✅ - Keep
- [ ] CONTRIBUTING.md - Missing 📝 - Should create

### /docs/
- [ ] TECHNOLOGY.md - Partially outdated ⚠️ - Update needed
  - Issue: Lists IndexedDB as 🔍 but project uses Firestore
  - Action: Update to reflect Firebase migration

- [ ] MCP_SETUP.md - Up-to-date ✅ - Move to /docs/guides/
...
```

#### B. Files to Move

```markdown
## Files to Move

### To /docs/architecture/
- TECHNOLOGY.md (from /docs/)
  - Reason: Core architecture document
  - Files that reference it: README.md, MCP_SETUP.md

### To /docs/guides/
- MCP_SETUP.md (from /docs/)
  - Reason: Setup guide
  - Referenced by: TECHNOLOGY.md, README.md
...
```

#### C. Files to Delete

```markdown
## Files to Delete

- /docs/OLD_SETUP.md
  - Reason: Superseded by new setup process
  - Last updated: 6 months ago
  - Not referenced by any other files
...
```

#### D. Files to Update

```markdown
## Files Needing Updates

### TECHNOLOGY.md
**Issues:**
- [ ] Lists IndexedDB as option, but project uses Firestore
- [ ] Missing Lucide React in styling section (already added ✅)
- [ ] References planned Figma integration

**Recommendations:**
- Update database section to reflect Firebase migration
- Remove or update Figma references based on current state
- Add section on Claude Code + MCP tooling (already added ✅)
...
```

#### E. Implementation vs Documentation Gap

```markdown
## Implementation vs Documentation

### Implemented but Not Documented
- ✅ Logger utility (src/utils/logger.ts)
- ✅ Firebase migration (code migrated, but docs outdated)
- ✅ i18n for player components (implemented but not in any guide)

### Documented but Not Implemented
- ❌ Figma Design System integration
- ❌ Score rendering with VexFlow
- ❌ MIDI processing features
- ❌ Computer vision score tracking
...
```

#### F. Incomplete Phases & Work

```markdown
## Incomplete Phases & Planned Work

### Phase 5 - Systematic Refactoring
- [x] Component translations ✅
- [x] Icon standardization ✅
- [ ] Admin section translations ⏳ (48+ strings remain)
- [ ] Form validation translations ⏳
- [ ] Cache management translations ⏳

### Phase 6 - Advanced Features (Not Started)
- [ ] Score rendering
- [ ] MIDI processing
- [ ] Adaptive arrangements
...
```

#### G. Broken Links & References

```markdown
## Broken Links

- /docs/SETUP.md links to `./database-setup.md` (doesn't exist)
- README.md links to `/docs/API.md` (doesn't exist)
- MCP_SETUP.md references `./TROUBLESHOOTING.md` (should be inline)
...
```

#### H. Recommendations

```markdown
## Recommendations

### High Priority
1. Update TECHNOLOGY.md to reflect Firebase migration
2. Move all guides to /docs/guides/
3. Create /docs/README.md as documentation map
4. Delete outdated OLD_* files

### Medium Priority
1. Document logger utility usage
2. Create Firebase migration guide
3. Update all internal links after file moves
4. Archive completed phase documentation

### Low Priority
1. Create CONTRIBUTING.md
2. Add inline examples to setup guides
3. Create API reference documentation
...
```

### 8. Ask for Confirmation on Unclear Items

**Before making changes, ask user about:**

1. **Files with ambiguous status:**
   - "forslag2.png is referenced but I'm not sure if it's still needed. Delete?"
   - "COLLABORATIVE_ANNOTATIONS_ANALYSIS.md - is this active work or should it be archived?"

2. **Documentation gaps:**
   - "Should I create a Firebase Migration Guide based on the scripts?"
   - "Create a documentation map (README) in /docs/?"

3. **Outdated planned features:**
   - "TECHNOLOGY.md lists MIDI processing as planned. Still relevant or remove?"
   - "Score rendering marked as 🔍 (research needed). Update status?"

### 9. Execute Changes

**After user confirmation, execute approved changes:**

1. **Move files:**
   ```bash
   mkdir -p docs/architecture docs/guides docs/specs docs/plans docs/audits docs/reference docs/templates
   mv docs/TECHNOLOGY.md docs/architecture/
   ```

2. **Update links in affected files:**
   - Use Edit tool to update relative paths

3. **Delete approved files:**
   ```bash
   git rm path/to/outdated-file.md
   ```

4. **Create missing documentation:**
   - Use Write tool to create stub files for critical missing docs

5. **Update README or create docs/README.md** with documentation map

### 10. Generate Final Summary

After changes, provide:

```markdown
## Documentation Audit Complete

### Changes Made
- ✅ Moved 8 files to organized folders
- ✅ Updated 15 internal links
- ✅ Deleted 3 outdated files
- ✅ Created 2 missing documentation files
- ✅ Updated TECHNOLOGY.md with current stack

### Remaining Work
- [ ] 3 files need manual review
- [ ] Admin section translation (48+ strings)
- [ ] Create comprehensive API reference

### Documentation Health: 🟢 Good
- 85% of docs are up-to-date
- All links valid
- Well organized structure
- Clear documentation map

### Next Steps
1. Review manually flagged files
2. Complete remaining translations
3. Keep TECHNOLOGY.md updated as stack evolves
```

## Important Guidelines

### Safety Rules
- **ASK before deleting** if any uncertainty about file importance
- **ASK before major reorganization** that affects many links
- **ASK about outdated planned features** - user may still want them documented
- **DO NOT delete** files referenced in git history without confirmation
- **DO NOT assume** technology choices - always check actual implementation

### Analysis Priorities
1. **Accuracy** - Does doc match reality?
2. **Organization** - Is it in the right place?
3. **Completeness** - Are there gaps?
4. **Maintenance** - Is it up-to-date?

### Agent Usage
- Use **codebase-analyzer** for deep implementation checks
- Use **Explore agent** to understand codebase structure
- Use `/validate_plan` for phase/plan validation
- Use **Grep** to find references and links
- Use **Glob** to find file patterns

### Output Format
- Always use markdown tables for comparisons
- Use checkboxes [ ] for actionable items
- Use emojis for status (✅ ❌ ⚠️ 📝 🗑️ 📦)
- Provide clear before/after for moves
- Link to specific line numbers when referencing code

## Success Criteria

The audit is successful when:

- ✅ All markdown files are catalogued and categorized
- ✅ Documentation structure is organized and logical
- ✅ All broken links are identified or fixed
- ✅ Implementation vs documentation gaps are identified
- ✅ Incomplete phases and work are clearly tracked
- ✅ User has clear action items for remaining work
- ✅ No uncertainty - all ambiguous items were clarified with user

## Usage

```
/docs-audit
```

This will perform a full documentation audit and organization pass, making approved changes and providing a comprehensive report on documentation health and remaining work.
