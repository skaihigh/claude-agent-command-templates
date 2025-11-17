# Secrets Setup Guide - React PWA

This guide explains how to securely configure secrets for this React PWA project.

## Security Architecture

This project uses a **two-tier security model**:

1. **Global MCP Secrets** (`~/.config/claude-mcp/mcp-secrets.env`)
   - Shared across ALL projects
   - MCP server API keys (Tavily, Memory Bank, etc.)
   - Loaded automatically via shell configuration

2. **Project-Local Secrets** (`.claude/settings.local.json` + `.env.local`)
   - Specific to THIS project only
   - API keys, endpoints, configuration
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

If not configured, see the main template library README.

---

## Step 2: Create Project-Local Settings

### 2.1 Copy the Example File

```bash
cd /path/to/your/pwa
cp .claude/settings.local.json.example .claude/settings.local.json
```

**IMPORTANT**: `.claude/settings.local.json` is git-ignored.

### 2.2 Configure Project Context

Edit `.claude/settings.local.json`:

```json
{
  "projectContext": {
    "architecture": "Component-based architecture in src/components/",
    "deploymentUrl": "https://your-app.example.com"
  }
}
```

---

## Step 3: Configure API Credentials

### 3.1 Create .env.local

Create `.env.local` in project root:

```bash
# API Configuration
VITE_API_BASE_URL=https://api.example.com
VITE_API_KEY=your-api-key-here

# Optional: Analytics
VITE_GA_TRACKING_ID=G-XXXXXXXXXX

# Optional: Feature Flags
VITE_ENABLE_BETA_FEATURES=false
```

**IMPORTANT**: `.env.local` is git-ignored. NEVER commit this file.

### 3.2 Reference in Code

```typescript
// src/services/api.ts
const API_BASE_URL = import.meta.env.VITE_API_BASE_URL;
const API_KEY = import.meta.env.VITE_API_KEY;

export const fetchData = async () => {
  const response = await fetch(`${API_BASE_URL}/endpoint`, {
    headers: {
      'Authorization': `Bearer ${API_KEY}`
    }
  });
  return response.json();
};
```

---

## Step 4: Verify .gitignore Protection

Check that your project `.gitignore` includes:

```gitignore
# Environment variables
.env.local
.env.*.local

# Claude Code configuration secrets
.claude/settings.local.json
.claude/**/*.local.md
.claude/.env
.mcp.local.json
*secrets*.json
*secrets*.env
*api-keys*.json
```

---

## Step 5: Service Worker & PWA Caching

**IMPORTANT**: Service workers cache content. Don't cache sensitive data!

### Don't Cache
❌ API responses with user data
❌ Authentication tokens
❌ Personalized content

### Safe to Cache
✅ Static assets (JS, CSS, images)
✅ App shell
✅ Public API responses (with proper headers)

**Example** (in `vite.config.ts` or service worker):

```typescript
// workbox-config.js
export default {
  runtimeCaching: [{
    urlPattern: /^https:\/\/api\.example\.com\/public\/.*/,
    handler: 'CacheFirst',
    options: {
      cacheName: 'api-cache',
      expiration: {
        maxEntries: 50,
        maxAgeSeconds: 300, // 5 minutes
      },
    },
  }],
  // Don't cache authenticated endpoints
  navigateFallback: '/index.html',
  navigateFallbackDenylist: [/^\/api\/user/],
};
```

---

## Security Best Practices

### ✅ DO
- Use environment variables for all secrets
- Keep `.env.local` and `settings.local.json` git-ignored
- Cache only public, non-sensitive data
- Implement Content Security Policy (CSP)
- Use HTTPS in production
- Validate all user input

### ❌ DON'T
- Hardcode API keys in source code
- Commit `.env.local` or `settings.local.json`
- Cache user data or auth tokens in service worker
- Expose API keys in client-side code (use backend proxy)
- Trust client-side validation alone

---

## Troubleshooting

### Environment Variables Not Loading

**Problem**: `import.meta.env.VITE_API_KEY` is undefined

**Solution**:
1. Verify `.env.local` exists in project root
2. Ensure variable names start with `VITE_`
3. Restart dev server: `pnpm dev`
4. Check variable is actually set: `cat .env.local`

### Service Worker Not Updating

**Problem**: Old cached content still showing

**Solution**:
```bash
# In browser DevTools
# Application > Service Workers > Unregister
# Application > Clear storage > Clear site data

# Or update service worker version
# In your SW file, bump the version/cache name
```

---

## Security Checklist

- [ ] All secrets in `.env.local` (not in code)
- [ ] `.gitignore` includes all secret patterns
- [ ] Service worker doesn't cache sensitive data
- [ ] CSP headers configured
- [ ] HTTPS enabled in production
- [ ] API keys have appropriate scopes/restrictions
- [ ] Input validation on all forms
- [ ] No secrets in client-side code

---

**Last Updated**: 2025-11-17 (Phase 3)
