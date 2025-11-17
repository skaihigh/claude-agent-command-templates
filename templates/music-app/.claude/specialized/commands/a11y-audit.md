---
description: Run comprehensive accessibility audit on component or page
---

@accessibility-expert

Audit accessibility for: $ARGUMENTS

Perform these checks:

1. **Automated Testing**
   - Run axe-core on the component/page
   - Check ESLint jsx-a11y violations
   - Review Lighthouse accessibility score

2. **Manual Review**
   - Keyboard navigation (tab order, focus visible)
   - Screen reader compatibility (ARIA labels, roles)
   - Color contrast ratios (4.5:1 text, 3:1 UI)
   - Touch target sizes (44x44px minimum)

3. **WCAG 2.1 AA Compliance**
   - Perceivable criteria
   - Operable criteria
   - Understandable criteria
   - Robust criteria

4. **Age-Appropriate Design**
   - Language complexity (10+ reading level)
   - Visual clarity
   - Error messages understandable

5. **Recommendations**
   - List all violations with severity
   - Provide code fixes for each issue
   - Suggest improvements

Output a detailed report with:
- ✅ Passed checks
- ⚠️  Warnings
- ❌ Critical issues (must fix)
- 💡 Suggestions (nice to have)
