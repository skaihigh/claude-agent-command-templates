---
description: |
  Refactor component CSS to use nested CSS with data attributes pattern
  Triggers: "refactor css", "update styles", "css pattern"
---

@react-architect @codebase-pattern-finder

Refactor the CSS for: $ARGUMENTS

## Goals

1. **Simplify HTML structure** - Fewer elements, cleaner markup
2. **Use data attributes** for state/variants instead of CSS class juggling
3. **Leverage semantic selectors** - style by meaning, not arbitrary names
4. **Single 768px breakpoint** for responsive behavior

## Philosophy: Less HTML is Better

The CSS pattern should enable **simpler HTML**, not require more wrapper divs:

### ❌ Avoid: Wrapper Soup
```tsx
<div className={styles.container}>
  <div className={styles.wrapper}>
    <div className={styles.inner}>
      <span className={`${styles.text} ${isActive ? styles.active : ''}`}>
        Content
      </span>
    </div>
  </div>
</div>
```

### ✅ Prefer: Flat, Semantic Structure
```tsx
<ul className={styles.container} data-variant={variant} role="list">
  <li role="listitem">
    <span data-component-name="label">Content</span>
  </li>
</ul>
```

## CSS Pattern to Apply

```css
/* Single base class with nested modifiers */
.container {
  display: flex;
  gap: 1em;

  /* State via data attributes */
  &[data-variant="primary"] { ... }
  &[data-variant="secondary"] { ... }
  &[data-disabled="true"] { ... }

  /* Direct children - prevents leakage */
  > [role="listitem"] {
    /* Semantic child selectors */
    [data-component-name="icon"] { ... }
    [data-component-name="label"] { ... }
  }
}

/* Single breakpoint */
@media only screen and (max-width: 768px) {
  .container { ... }
}
```

## Refactoring Checklist

### Step 1: Analyze Current Structure
- [ ] Count HTML elements - can any be removed?
- [ ] Identify class-based variants (e.g., `.active`, `.disabled`, `.primary`)
- [ ] Find conditional className logic in JSX
- [ ] Note multiple media queries that could consolidate

### Step 2: Simplify HTML
- [ ] Remove unnecessary wrapper divs
- [ ] Use semantic elements (`ul/li`, `nav`, `section`, `article`)
- [ ] Add ARIA roles where semantic elements aren't appropriate
- [ ] Replace `<div>` with `<span>` for inline content

### Step 3: Convert to Data Attributes
- [ ] Replace `.variant-primary` → `[data-variant="primary"]`
- [ ] Replace `.is-active` → `[data-active="true"]`
- [ ] Replace `.disabled` → `[data-disabled="true"]` or `&:disabled`
- [ ] Replace `.size-sm/.size-lg` → `[data-size="sm"]`

### Step 4: Use Semantic Selectors
- [ ] Style by `[role="..."]` where appropriate
- [ ] Use `[data-component-name="..."]` for component parts
- [ ] Use direct child `>` to prevent style leakage
- [ ] Nest related styles to show hierarchy

### Step 5: Consolidate Media Queries
- [ ] Merge multiple breakpoints into single 768px query
- [ ] Use mobile-first OR desktop-first consistently
- [ ] Remove redundant responsive styles

## Reference Pattern

Look at `frontend-react/src/components/molecules/Legends/Legends.module.css` as the canonical example of this pattern.

## Output

Provide:
1. **Before/After HTML** - Show element count reduction
2. **Refactored CSS** - Full `.module.css` file
3. **Updated TSX** - Component with data attributes
4. **Summary** - What was simplified and why
