# Secrets Setup Guide - Firebase Full-Stack App

This guide explains how to securely configure secrets for this Firebase full-stack application.

## Security Architecture

This project uses a **three-tier security model**:

1. **Global MCP Secrets** (`~/.config/claude-mcp/mcp-secrets.env`)
   - Shared across ALL projects
   - MCP server API keys
   - Loaded automatically via shell configuration

2. **Project-Local Secrets** (`.claude/settings.local.json` + `.env.local`)
   - Frontend Firebase configuration
   - Public API keys (safe for client-side)
   - Project context

3. **Server Secrets** (Cloud Functions `.env`)
   - Firebase Admin SDK
   - Third-party API keys (Stripe, SendGrid, etc.)
   - Database credentials
   - **NEVER exposed to client**

---

## Step 1: Verify Global MCP Secrets

**Verify**:
```bash
cat ~/.config/claude-mcp/mcp-secrets.env
echo $TAVILY_API_KEY
```

Ensure `firebase` MCP is in VS Code mcp.json (no API key needed).

---

## Step 2: Create Project-Local Settings

```bash
cd /path/to/your/firebase-app
cp .claude/settings.local.json.example .claude/settings.local.json
```

Edit `.claude/settings.local.json`:

```json
{
  "projectContext": {
    "firebaseProject": "your-actual-firebase-project-id",
    "deploymentUrl": "https://your-app.web.app",
    "regions": "us-central1"
  }
}
```

---

## Step 3: Configure Frontend Secrets

### 3.1 Get Firebase Config

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Project Settings > General > Your apps > Web app
4. Copy the `firebaseConfig` object

### 3.2 Create .env.local (Frontend)

Create `.env.local` in project root:

```bash
# Firebase Client Configuration (safe for frontend)
VITE_FIREBASE_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
VITE_FIREBASE_AUTH_DOMAIN=your-app.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project-id
VITE_FIREBASE_STORAGE_BUCKET=your-project-id.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789012
VITE_FIREBASE_APP_ID=1:123456789012:web:xxxxxxxxxxxxxxxxxxxxx
VITE_FIREBASE_MEASUREMENT_ID=G-XXXXXXXXXX

# App Configuration
VITE_APP_ENV=development
```

**Note**: Firebase client API keys are safe to expose (protected by security rules).

---

## Step 4: Configure Server Secrets (Cloud Functions)

### 4.1 Firebase Admin SDK

**DO NOT** download or commit service account JSON files!

Instead, use Firebase Functions environment:

```bash
# Functions use Firebase Admin SDK automatically
# No service account key needed in production

# For local development, use Firebase Emulator
firebase emulators:start
```

### 4.2 Third-Party API Keys (Functions)

For Cloud Functions secrets:

```bash
# Set secrets using Firebase CLI
firebase functions:secrets:set STRIPE_API_KEY
firebase functions:secrets:set SENDGRID_API_KEY

# Access in functions
import { defineSecret } from 'firebase-functions/params';
const stripeKey = defineSecret('STRIPE_API_KEY');

export const myFunction = onRequest(
  { secrets: [stripeKey] },
  async (req, res) => {
    const stripe = new Stripe(stripeKey.value());
    // ...
  }
);
```

### 4.3 Local Functions Development

For local emulator, create `functions/.env`:

```bash
# functions/.env (git-ignored)
STRIPE_API_KEY=sk_test_xxxxxxxxxxxxxxxxxxxxx
SENDGRID_API_KEY=SG.xxxxxxxxxxxxxxxxxxxxx
```

---

## Step 5: Security Rules

### 5.1 Firestore Rules

Update `firestore.rules` when changing data model:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Public read, authenticated write
    match /posts/{postId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### 5.2 Storage Rules

Update `storage.rules`:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // User uploads
    match /uploads/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 5.3 Deploy Rules

```bash
firebase deploy --only firestore:rules,storage:rules
```

---

## Step 6: Verify .gitignore Protection

Ensure `.gitignore` includes:

```gitignore
# Environment variables
.env.local
.env.*.local

# Firebase Admin SDK (NEVER commit!)
*firebase-adminsdk*.json
serviceAccountKey.json

# Firebase cache
.firebase/
firebase-debug.log
firestore-debug.log
ui-debug.log
*.cache

# Cloud Functions
functions/.env
functions/node_modules/
functions/lib/

# Claude Code secrets
.claude/settings.local.json
.claude/**/*.local.md
*secrets*.json
*secrets*.env
```

---

## Step 7: Multi-Environment Setup

### Development
```bash
# .env.development
VITE_FIREBASE_PROJECT_ID=your-app-dev
VITE_APP_ENV=development
```

### Staging
```bash
# .env.staging
VITE_FIREBASE_PROJECT_ID=your-app-staging
VITE_APP_ENV=staging
```

### Production
```bash
# .env.production
VITE_FIREBASE_PROJECT_ID=your-app-prod
VITE_APP_ENV=production
```

Use different Firebase projects for each environment!

---

## Testing with Emulators

```bash
# Start all emulators
firebase emulators:start

# Your app connects to local emulators
# No production data affected
# Free to test without costs
```

Configure in code:

```typescript
// src/services/firebase.ts
if (import.meta.env.VITE_APP_ENV === 'development') {
  connectAuthEmulator(auth, 'http://localhost:9099');
  connectFirestoreEmulator(db, 'localhost', 8080);
  connectStorageEmulator(storage, 'localhost', 9199);
}
```

---

## Security Best Practices

### ✅ DO
- Use Firebase security rules to protect data
- Use different projects for dev/staging/prod
- Store server secrets in Firebase Functions secrets
- Use Firebase Admin SDK for privileged operations
- Test with emulators before deploying
- Implement authentication and authorization
- Validate data in security rules AND functions

### ❌ DON'T
- Commit `serviceAccountKey.json` files
- Use production project for development
- Trust client-side validation alone
- Expose server API keys to frontend
- Skip security rules ("anyone can read/write")
- Share credentials via Slack/email
- Use admin SDK in frontend code

---

## Troubleshooting

### Permission Denied Errors

**Problem**: Firestore/Storage permission denied

**Solution**:
1. Check security rules allow the operation
2. Verify user is authenticated
3. Test rules in Firebase Console Rules Playground
4. Check Cloud Functions logs for errors

### Functions Not Accessing Secrets

**Problem**: Cloud Functions can't read secrets

**Solution**:
```bash
# List configured secrets
firebase functions:secrets:access STRIPE_API_KEY

# Verify secret is declared in function
# secrets: [stripeKey]
```

### Emulators Not Starting

**Problem**: Firebase emulators fail to start

**Solution**:
1. Check ports aren't in use (9099, 8080, 9199, etc.)
2. Initialize emulators: `firebase init emulators`
3. Check `firebase.json` configuration
4. Clear cache: `rm -rf ~/.cache/firebase/`

---

## Security Checklist

- [ ] All frontend secrets in `.env.local`
- [ ] All server secrets in Firebase Functions secrets
- [ ] NO `serviceAccountKey.json` in project
- [ ] Firestore rules configured and tested
- [ ] Storage rules configured and tested
- [ ] Different Firebase projects for dev/prod
- [ ] `.gitignore` includes all secret patterns
- [ ] Security rules validate ALL user input
- [ ] Authentication required for sensitive operations
- [ ] Admin operations only in Cloud Functions
- [ ] Tested with Firebase Emulator Suite

---

## Additional Resources

- [Firebase Security Rules](https://firebase.google.com/docs/rules)
- [Cloud Functions Secrets](https://firebase.google.com/docs/functions/config-env#secret-manager)
- [Firebase Admin SDK](https://firebase.google.com/docs/admin/setup)
- [Emulator Suite](https://firebase.google.com/docs/emulator-suite)

---

**Last Updated**: 2025-11-17 (Phase 3)
