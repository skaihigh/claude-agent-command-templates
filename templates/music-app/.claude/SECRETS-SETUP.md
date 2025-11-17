# Secrets Setup Guide - Music App

This guide explains how to securely configure secrets for this music practice PWA project.

## Security Architecture

This project uses a **two-tier security model**:

1. **Global MCP Secrets** (`~/.config/claude-mcp/mcp-secrets.env`)
   - Shared across ALL projects
   - MCP server API keys (Figma, Context7, Tavily, etc.)
   - Loaded automatically via shell configuration

2. **Project-Local Secrets** (`.claude/settings.local.json` + `.env.local`)
   - Specific to THIS project only
   - Firebase configuration
   - Project-specific API keys
   - **NEVER committed to git** (protected by .gitignore)

---

## Step 1: Verify Global MCP Secrets

Your global MCP secrets should already be configured from Phase 1.

**Verify**:
```bash
# Check secrets file exists
cat ~/.config/claude-mcp/mcp-secrets.env

# Verify environment variables loaded
echo $TAVILY_API_KEY
echo $MEMORY_BANK_ROOT
```

**Expected MCP servers**:
- `firebase` - Firebase tools (no API key needed)
- `tavily-mcp` - Web search (uses `$TAVILY_API_KEY`)
- `@allpepper/memory-bank-mcp` - Memory bank (uses `$MEMORY_BANK_ROOT`)

If not configured, see the main template library README.

---

## Step 2: Create Project-Local Settings

### 2.1 Copy the Example File

```bash
cd /path/to/your/music-app
cp .claude/settings.local.json.example .claude/settings.local.json
```

**IMPORTANT**: `.claude/settings.local.json` is git-ignored. It's safe to put project-specific config here.

### 2.2 Configure Firebase Project

Edit `.claude/settings.local.json`:

```json
{
  "projectContext": {
    "firebaseProject": "your-actual-firebase-project-id",
    "tenantId": "your-tenant-id",
    "deploymentUrl": "https://your-app.web.app"
  }
}
```

### 2.3 Add Project-Specific MCP Servers (Optional)

If you need MCP servers unique to this project:

```json
{
  "mcpServers": {
    "music-library-api": {
      "command": "npx",
      "args": ["-y", "music-library-mcp"],
      "env": {
        "MUSIC_API_KEY": "${MUSIC_API_KEY}"
      }
    }
  }
}
```

Then add `MUSIC_API_KEY` to your shell secrets or `.env.local`.

---

## Step 3: Configure Firebase Credentials

### 3.1 Get Firebase Config

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to Project Settings > General
4. Scroll to "Your apps" > Web app
5. Copy the `firebaseConfig` object

### 3.2 Create .env.local

Create `.env.local` in project root (NOT in .claude/):

```bash
# Firebase Configuration
VITE_FIREBASE_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VITE_FIREBASE_AUTH_DOMAIN=your-app.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project-id
VITE_FIREBASE_STORAGE_BUCKET=your-project-id.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789012
VITE_FIREBASE_APP_ID=1:123456789012:web:xxxxxxxxxxxxxxxxxxxxx
VITE_FIREBASE_MEASUREMENT_ID=G-XXXXXXXXXX

# Tenant Configuration
VITE_TENANT_ID=your-tenant-id

# Optional: Music Library API
VITE_MUSIC_LIBRARY_API_KEY=your-music-api-key
```

**IMPORTANT**: `.env.local` is git-ignored. NEVER commit this file.

### 3.3 Reference in Code

In your Firebase initialization:

```typescript
// src/services/firebase.ts
const firebaseConfig = {
  apiKey: import.meta.env.VITE_FIREBASE_API_KEY,
  authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN,
  projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID,
  storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET,
  messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID,
  appId: import.meta.env.VITE_FIREBASE_APP_ID,
};
```

---

## Step 4: Verify .gitignore Protection

Check that your project `.gitignore` includes:

```gitignore
# Environment variables with secrets
.env.local
.env.*.local

# Claude Code configuration secrets (NEVER commit)
.claude/settings.local.json
.claude/**/*.local.md
.claude/.env
.mcp.local.json
*secrets*.json
*secrets*.env
*api-keys*.json

# Firebase Admin SDK (NEVER commit these!)
*firebase-adminsdk*.json
serviceAccountKey.json

# Firebase cache
.firebase/
firebase-debug.log
firestore-debug.log
ui-debug.log
*.cache
```

If missing, add these patterns to `.gitignore`.

---

## Step 5: Team Setup (Optional)

If working with a team:

### Share Template, Not Secrets
✅ Commit: `.claude/settings.local.json.example`
✅ Commit: `.claude/SECRETS-SETUP.md` (this file)
❌ NEVER commit: `.claude/settings.local.json`
❌ NEVER commit: `.env.local`

### Document Required Secrets

Create a `secrets-template.md` in your project docs:

```markdown
# Required Secrets

## Firebase
- Get from Firebase Console > Project Settings
- Add to `.env.local`

## Music Library API (if used)
- Request API key from [provider]
- Add to `.env.local` as `VITE_MUSIC_LIBRARY_API_KEY`
```

---

## Troubleshooting

### Claude Code Can't Access MCP Servers

**Problem**: MCP servers not available in Claude Code

**Solution**:
1. Verify global secrets loaded: `echo $TAVILY_API_KEY`
2. Restart VS Code
3. Check VS Code mcp.json uses `${ENV_VAR}` syntax
4. Check Claude Code output panel for errors

### Firebase Not Initializing

**Problem**: Firebase initialization fails

**Solution**:
1. Verify `.env.local` exists in project root
2. Check all `VITE_FIREBASE_*` variables are set
3. Restart dev server to reload environment
4. Check browser console for specific errors

### Secrets Accidentally Committed

**Problem**: Committed `.env.local` or `settings.local.json` to git

**Solution**:
```bash
# Remove from git history (DANGEROUS - coordinate with team)
git rm --cached .env.local
git rm --cached .claude/settings.local.json
git commit -m "Remove accidentally committed secrets"

# Rotate all exposed secrets immediately!
# - Generate new Firebase config
# - Regenerate all API keys
# - Update .env.local with new values
```

### Project-Specific MCP Not Working

**Problem**: MCP server in `.claude/settings.local.json` not loading

**Solution**:
1. Verify JSON syntax is valid
2. Check the MCP server is installed: `npx -y package-name --version`
3. Verify environment variables are loaded
4. Restart VS Code
5. Check Claude Code output panel

---

## Best Practices

### ✅ DO
- Use environment variables for all secrets
- Keep `.env.local` and `settings.local.json` git-ignored
- Document required secrets in team docs
- Use different Firebase projects for dev/staging/prod
- Rotate secrets regularly
- Use Firebase security rules to protect data

### ❌ DON'T
- Hardcode API keys in source code
- Commit `.env.local` or `settings.local.json`
- Share secrets via Slack/email
- Use production Firebase project for development
- Copy-paste secrets into AI chat interfaces
- Store secrets in screenshots or documentation

---

## Security Checklist

Before deploying:

- [ ] All secrets in `.env.local` (not in code)
- [ ] `.gitignore` includes all secret patterns
- [ ] Firebase security rules configured
- [ ] Storage rules restrict access appropriately
- [ ] No `serviceAccountKey.json` in project
- [ ] `.claude/settings.local.json` is git-ignored
- [ ] All secrets use environment variable syntax
- [ ] Team members have setup guide
- [ ] Different Firebase projects for dev/prod
- [ ] API keys have appropriate scopes/restrictions

---

## Additional Resources

- [Firebase Security Rules](https://firebase.google.com/docs/rules)
- [Vite Environment Variables](https://vitejs.dev/guide/env-and-mode.html)
- [Claude Code MCP Documentation](https://code.claude.com/docs/mcp)
- Main template library: `~/Documents/PRIVATE/claude-templates/README.md`

---

**Last Updated**: 2025-11-17 (Phase 3)
