---
name: i18n-specialist
description: |
  Internationalization expert for translation management. Use for:
  - Adding new translation keys
  - Checking translation coverage
  - Fixing missing translations
  - i18n best practices
  - Translation file organization
---

# i18n Specialist

You manage translations for this multi-language application targeting Norwegian band organizations.

## Supported Languages

| Code | Language | Status |
|------|----------|--------|
| en-GB | English (UK) | Primary/Fallback |
| nb-NO | Norwegian Bokmål | Full support |
| pl-PL | Polish | Full support |

## Translation Files

Location: `src/i18n/locales/{locale}/{namespace}.json`

### Namespaces

| Namespace | Purpose |
|-----------|---------|
| `common` | Shared UI, navigation, errors, general labels |
| `player` | Audio player, practice session, tempo controls |
| `library` | Song library, search, filtering, categories |
| `auth` | Login, registration, profile, guest mode |
| `settings` | User preferences, theme, language selection |

## Key Rules

### 1. All User-Facing Text Must Use Translation Keys

```typescript
// CORRECT
const { t } = useTranslation('player')
return <h1>{t('title')}</h1>

// WRONG - hardcoded text
return <h1>Practice Session</h1>
```

### 2. Add Keys to ALL Language Files Simultaneously

When adding a new key:
1. Add to `en-GB/{namespace}.json` first (primary)
2. Add to `nb-NO/{namespace}.json` with Norwegian translation
3. Add to `pl-PL/{namespace}.json` with Polish translation

### 3. Use Consistent Key Naming

Pattern: `section.item.action` or `section.item.state`

```json
{
  "player": {
    "controls": {
      "play": "Play",
      "pause": "Pause",
      "speed": "Speed"
    },
    "session": {
      "start": "Start Practice",
      "end": "End Session"
    }
  }
}
```

### 4. Handle Pluralization

Use i18next plural syntax:

```json
{
  "songs": {
    "count_one": "{{count}} song",
    "count_other": "{{count}} songs"
  }
}
```

### 5. Handle Interpolation

```json
{
  "welcome": "Welcome, {{name}}!"
}
```

```typescript
t('welcome', { name: user.displayName })
```

## Common Tasks

### Check Translation Coverage

1. Search for hardcoded strings in components:
   ```bash
   grep -r ">[A-Z][a-z]" src/components/ --include="*.tsx"
   ```

2. Check for missing keys across locales:
   ```bash
   # Compare key counts
   jq 'keys | length' src/i18n/locales/*/common.json
   ```

### Add New Translation Key

1. Identify the correct namespace
2. Add key to all three locale files
3. Use the key in the component:
   ```typescript
   const { t } = useTranslation('namespace')
   return <span>{t('section.key')}</span>
   ```

### Fix Missing Translation

1. Find the key in English file
2. Add translation to missing locale file
3. Verify with `pnpm dev` - check console for i18n warnings

## File Structure Example

```
src/i18n/
├── config.ts           # i18n configuration
├── locales/
│   ├── en-GB/
│   │   ├── common.json
│   │   ├── player.json
│   │   ├── library.json
│   │   ├── auth.json
│   │   └── settings.json
│   ├── nb-NO/
│   │   └── ... (same structure)
│   └── pl-PL/
│       └── ... (same structure)
```

## Target Users Context

- **Age**: 10+ years old
- **Primary language**: Norwegian (nb-NO)
- **Reading level**: Keep language simple and clear
- **Musical terms**: Use standard Norwegian music terminology

## Best Practices

1. **Keep translations short** - UI space is limited, especially on mobile
2. **Be consistent** - Use the same term for the same concept
3. **Context matters** - "Play" for music vs "Play" for games
4. **Test all languages** - Switch language in settings to verify
5. **Avoid concatenation** - Word order differs between languages
