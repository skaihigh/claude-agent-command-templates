# Create Storybook Story

When the user runs `/create-story [component-name]`, create a comprehensive Storybook story file for the specified component with accessibility tests, play functions, and proper typing.

## Your Task

1. **Find the Component**
   - Use `codebase-locator` to find the component file
   - If component name is ambiguous, show options to user
   - Read the component file to understand its props and behavior

2. **Analyze the Component**
   - Identify all props and their types
   - Determine component category (atom/molecule/organism)
   - Note any variants, states, or modes
   - Check for existing test files
   - Review any related components that might be imported

3. **Create the Story File**

   Generate a complete `.stories.tsx` file with:

   ### Required Elements
   - CSF 3.0 format with TypeScript
   - `Meta<typeof Component>` typing
   - At least 3 story variants (Default + edge cases)
   - Comprehensive args for all props
   - JSDoc comments for each story
   - Proper atomic design categorization in title

   ### Accessibility
   - Configure `parameters.a11y` for accessibility testing
   - Add an Accessibility story variant if component is interactive
   - Document ARIA requirements in story descriptions

   ### Interaction Testing
   - Add play functions for interactive components
   - Test user flows (click, type, navigate)
   - Use `@storybook/test` utilities (`within`, `userEvent`, `expect`)
   - Test keyboard navigation where applicable

   ### Documentation
   - Add component description in meta
   - Document each story's purpose
   - Include usage examples in JSDoc

4. **Create Test File** (if it doesn't exist)

   Generate `Component.test.tsx` using `composeStories`:
   ```typescript
   import { composeStories } from '@storybook/react'
   import * as stories from './Component.stories'

   const { Default, Variant1, Variant2 } = composeStories(stories)

   describe('Component', () => {
     it('renders default state', () => {
       render(<Default />)
       // assertions
     })
   })
   ```

5. **Report to User**
   - Summarize what was created
   - List all story variants
   - Note accessibility considerations
   - Suggest composition opportunities
   - Provide next steps

## Story Template Structure

```typescript
import type { Meta, StoryObj } from '@storybook/react'
import { within, userEvent, expect, fn } from '@storybook/test'
import { ComponentName } from './ComponentName'

const meta = {
  title: 'Atoms|Molecules|Organisms/ComponentName',
  component: ComponentName,
  tags: ['autodocs'],
  parameters: {
    layout: 'centered|padded|fullscreen',
    docs: {
      description: {
        component: 'Component description here...',
      },
    },
  },
  argTypes: {
    // Define arg types with controls
    propName: {
      control: 'select|text|boolean|...',
      options: [...],
      description: 'Prop description',
    },
  },
} satisfies Meta<typeof ComponentName>

export default meta
type Story = StoryObj<typeof meta>

/**
 * Default component state
 */
export const Default: Story = {
  args: {
    // Default props
  },
}

/**
 * Variant description
 */
export const VariantName: Story = {
  args: {
    ...Default.args,
    // Modified props
  },
}

/**
 * Interactive test example
 */
export const WithInteraction: Story = {
  args: {
    ...Default.args,
    onClick: fn(),
  },
  play: async ({ args, canvasElement }) => {
    const canvas = within(canvasElement)

    // Interaction tests
    const button = canvas.getByRole('button')
    await userEvent.click(button)
    await expect(args.onClick).toHaveBeenCalled()
  },
}

/**
 * Accessibility testing
 */
export const Accessibility: Story = {
  args: Default.args,
  parameters: {
    a11y: {
      config: {
        rules: [
          { id: 'color-contrast', enabled: true },
          { id: 'button-name', enabled: true },
        ],
      },
    },
  },
  play: async ({ canvasElement }) => {
    const canvas = within(canvasElement)

    // Test keyboard navigation
    const interactive = canvas.getByRole('button')
    interactive.focus()
    await expect(interactive).toHaveFocus()

    // Test ARIA attributes
    await expect(interactive).toHaveAttribute('aria-label')
  },
}
```

## Component-Specific Patterns

### For Atoms (Buttons, Inputs, Icons)
- Focus on variants (primary, secondary, destructive)
- Size variants (sm, md, lg)
- State variants (default, hover, disabled, loading)
- Accessibility keyboard tests
- Icon/label combinations

### For Molecules (Forms, Cards, Menus)
- Composition examples (show component parts)
- Multiple content states (empty, populated, loading)
- Interaction flows in play functions
- Responsive behavior examples
- Error states

### For Organisms (Headers, Footers, Panels)
- Full feature showcase
- Multiple use case examples
- Integration with molecules/atoms
- Responsive layouts
- Complex interaction flows

### For Templates/Pages
- Import and compose from existing stories
- Use real content examples
- Show multiple page states
- Responsive breakpoints
- Full user flows

## Atomic Design Categories

Use these title prefixes:
- `Atoms/ComponentName` - Basic building blocks
- `Molecules/ComponentName` - Simple combinations
- `Organisms/ComponentName` - Complex sections
- `Templates/ComponentName` - Page layouts
- `Pages/ComponentName` - Complete pages
- `Design System/ComponentName` - System-level (icons, tokens, etc.)

## Best Practices Checklist

Before completing, verify:

✅ Story file uses CSF 3.0 format
✅ TypeScript types are correct (`Meta<typeof Component>`)
✅ At least 3 story variants exist
✅ Default story has complete args
✅ Interactive components have play functions
✅ Accessibility tests are included
✅ Component category in title is correct
✅ All variants are documented with JSDoc
✅ Args use meaningful defaults
✅ Test file created (if needed)
✅ Follows project's existing story patterns

## Error Handling

If issues occur:

- **Component not found**: Ask user for correct path or name
- **No TypeScript types**: Note it and create basic args
- **Complex props**: Document in JSDoc and provide examples
- **No accessibility requirements**: Add basic tests anyway
- **Existing story file**: Ask user if they want to enhance or replace it

## Example Invocation

**User**: `/create-story AudioPlayer`

**You should**:
1. Find `AudioPlayer.tsx` file
2. Analyze its props (src, playing, onPlay, onPause, etc.)
3. Categorize as "Organism" (complex audio control)
4. Create comprehensive story with:
   - Default (ready to play)
   - Playing (audio playing state)
   - Paused (audio paused state)
   - Loading (loading audio file)
   - Error (failed to load)
   - WithPlayFunction (test play/pause interaction)
   - Accessibility (keyboard controls test)
5. Create test file using composeStories
6. Report: "Created 7 stories for AudioPlayer organism with interaction tests and a11y coverage"

## Integration with Other Commands

This command works well with:
- `/storybook-audit` - First audit, then use `/create-story` for specific components
- `/test-coverage` - Verify tests are comprehensive
- `/a11y-audit` - Ensure accessibility standards are met

## Output Example

```markdown
# ✅ Created Storybook Story for AudioPlayer

## Files Created
- ✅ `src/components/audio/AudioPlayer.stories.tsx` (247 lines)
- ✅ `src/components/audio/AudioPlayer.test.tsx` (89 lines)

## Story Variants (7 total)
1. **Default** - Player ready to start
2. **Playing** - Active playback state
3. **Paused** - Paused playback state
4. **Loading** - Loading audio file
5. **Error** - Failed to load audio
6. **WithInteraction** - Play function with interaction test
7. **Accessibility** - Keyboard navigation and ARIA tests

## Accessibility Features
- ✅ ARIA labels for all controls
- ✅ Keyboard navigation tests (Space, Enter)
- ✅ Focus management
- ✅ Screen reader announcements
- ✅ Color contrast verification

## Test Coverage
- ✅ Rendering tests for all states
- ✅ Interaction tests (play, pause, seek)
- ✅ Keyboard event tests
- ✅ Accessibility assertions

## Composition Opportunities
This organism could be composed with:
- `Looper` molecule - Add loop controls
- `BarTracker` molecule - Add bar/beat tracking
- `VolumeControl` atom - Add volume slider

Create "Audio Control Panel" template?

## Next Steps
1. Run `npm run storybook` to view stories
2. Test accessibility with a11y addon
3. Consider creating Audio Control Panel template
4. Add visual regression tests if using Chromatic

Story file created at: [src/components/audio/AudioPlayer.stories.tsx](src/components/audio/AudioPlayer.stories.tsx)
```

## Remember

- **Quality over quantity** - Better to have 5 excellent stories than 20 mediocre ones
- **Follow project conventions** - Match existing story patterns
- **Accessibility is mandatory** - Every interactive component needs a11y tests
- **Test interactions** - Play functions catch regressions
- **Enable exploration** - Args should let users play with all props
- **Document decisions** - Explain why variants exist
