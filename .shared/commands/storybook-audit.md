# Storybook Component Audit & Implementation

When the user runs `/storybook-audit`, perform a comprehensive analysis of the codebase to identify Storybook opportunities and create a prioritized implementation plan.

## Your Task

Execute the following workflow:

### Step 1: Invoke the storybook-expert Agent

Launch the `storybook-expert` agent with this prompt:

```
Analyze this codebase and identify all components that should have Storybook stories.

For each component:
1. Determine if it already has a story file
2. Categorize by atomic design level (atom/molecule/organism/template/page)
3. Assess complexity and reusability
4. Note any existing stories that need enhancement

Provide a detailed analysis report with:
- Components WITHOUT stories (prioritized by impact)
- Existing stories that need enhancement
- Composition opportunities (higher-order stories from existing ones)
- Recommended Storybook addons to install
- Implementation roadmap

Do NOT create any stories yet - just analyze and report.
```

### Step 2: Review the Agent's Report

Once the `storybook-expert` agent completes its analysis, review the findings and present them to the user in a clear, actionable format.

### Step 3: Ask for User Confirmation

Present the analysis to the user and ask:

```
I've completed the Storybook audit. Here's what I found:

[Summary of findings]

Would you like me to:
1. Create stories for all high-priority components
2. Create stories for specific components (which ones?)
3. Enhance existing stories with accessibility/interaction tests
4. Create composite stories (organisms/templates/pages)
5. All of the above

Please let me know how you'd like to proceed.
```

### Step 4: Execute Based on User Choice

Based on the user's response, invoke the `storybook-expert` agent again with specific implementation instructions.

## Example Output Format

```markdown
# Storybook Component Audit Results

## Summary
- **Total Components**: 47
- **Components WITH Stories**: 12 (26%)
- **Components WITHOUT Stories**: 35 (74%)
- **High Priority Missing**: 8 components
- **Enhancement Opportunities**: 5 existing stories

## High Priority Components (Missing Stories)

### 🎯 Critical Functionality
1. **[ComponentName]** (`src/components/[path]/[ComponentName].tsx`)
   - Type: Organism/Molecule/Atom
   - Complexity: High/Medium/Low
   - Why: Core app functionality, complex state, accessibility critical
   - Story needs: Various states, error handling, keyboard controls, a11y tests

2. **[AnotherComponent]** (`src/components/[path]/[ComponentName].tsx`)
   - Type: Molecule
   - Complexity: Medium
   - Reused: X locations
   - Why: Reusable control component, needs documentation

### 🔄 Highly Reusable
3. **[ReusableComponent]** (`src/components/ui/[ComponentName].tsx`)
   - Type: Atom
   - Complexity: Low
   - Reused: X locations
   - Why: Simple, reusable, good documentation candidate

[... continue for all high priority items ...]

## Existing Stories to Enhance

1. **Button** (`src/components/ui/button.stories.tsx`)
   - ✅ Has: Good variants, args setup
   - ❌ Missing: Play functions, accessibility tests
   - Recommendation: Add keyboard interaction tests

2. **PageHeader** (`src/components/molecules/PageHeader.stories.tsx`)
   - ✅ Has: Comprehensive examples, accessibility story
   - ❌ Missing: Interaction tests for action buttons
   - Recommendation: Add play function for button clicks

[... continue ...]

## Composition Opportunities

### 1. [Complex Feature Component] (Organism)
**Compose from**: [Component1] + [Component2] + [Component3] + [Component4]
**Benefits**: Demonstrate full feature UI, test component integration
**Story types**: Default, Active/Inactive states, Error states

### 2. [Page Template] (Template)
**Compose from**: PageHeader + Card + Form components
**Benefits**: Full page example, responsive behavior showcase

### 3. [Dashboard/Admin Page] (Page)
**Compose from**: Layout + PageHeader + DataTable + Charts
**Benefits**: Complete page documentation

[... continue ...]

## Recommended Storybook Addons

### Essential (Install Now)
- `@storybook/addon-a11y` - Accessibility testing ⭐ **Critical**
- `@storybook/test` - Play functions and interactions ⭐ **Critical**
- `@storybook/addon-coverage` - Test coverage tracking

### Nice to Have
- `@storybook/addon-viewport` - Responsive design testing
- `storybook-dark-mode` - Dark theme toggle
- `@storybook/addon-designs` - Link Figma designs

## Implementation Roadmap

### Phase 1: Critical Components
1. [Critical Component 1] story + tests
2. [Critical Component 2] story + tests
3. [Critical Component 3] story + tests
4. Install a11y addon and test all existing stories

**Estimated effort**: 8-12 hours

### Phase 2: Reusable Atoms
1. [Reusable Component 1]
2. [Reusable Component 2]
3. [Reusable Component 3]
4. [Reusable Component 4]

**Estimated effort**: 6-8 hours

### Phase 3: Enhancement & Composition
1. Add play functions to existing stories
2. Create [Complex Feature] organism
3. Create page templates
4. Add MDX documentation for complex components

**Estimated effort**: 10-14 hours

### Phase 4: Polish & Documentation (Week 4)
1. Visual regression testing setup
2. Full design system documentation
3. Usage guidelines for team
4. Integration with CI/CD

**Estimated effort**: 6-8 hours

## Configuration Needed

```bash
# Install required dependencies
npm install --save-dev @storybook/addon-a11y @storybook/test @storybook/addon-coverage

# Update .storybook/main.ts
addons: [
  '@storybook/addon-a11y',
  '@storybook/addon-interactions',
  '@storybook/addon-coverage',
]
```

## Next Steps

Choose an option to proceed:
1. **Full implementation** - Create all high-priority stories
2. **Phase 1 only** - Focus on critical audio components
3. **Enhancement** - Improve existing stories first
4. **Custom selection** - Pick specific components

What would you like to do?
```

## Important Notes

- **Always show the full analysis** before making changes
- **Get user confirmation** on what to implement
- **Provide time estimates** for realistic planning
- **Link to components** with file paths for easy navigation
- **Explain WHY** each component is prioritized
- **Show composition opportunities** to reduce duplication

## Success Criteria

✅ User receives clear, actionable audit report
✅ Priorities are explained and justified
✅ Implementation effort is estimated
✅ User can make informed decision on next steps
✅ Composition opportunities reduce future work
✅ Team understands the value of each story
