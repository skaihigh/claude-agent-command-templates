# Secrets Setup Guide - Backend API

This guide explains how to securely configure secrets for this Node.js backend API.

## Security Architecture

This project uses a **two-tier security model**:

1. **Global MCP Secrets** (`~/.config/claude-mcp/mcp-secrets.env`)
   - Shared across ALL projects
   - MCP server API keys
   - Loaded automatically via shell configuration

2. **Server Secrets** (`.env`)
   - Database credentials
   - JWT secrets
   - Third-party API keys
   - **NEVER committed to git** (protected by .gitignore)
   - **NEVER exposed to clients**

---

## Step 1: Verify Global MCP Secrets

**Verify**:
```bash
cat ~/.config/claude-mcp/mcp-secrets.env
echo $TAVILY_API_KEY
```

---

## Step 2: Create Project-Local Settings

```bash
cd /path/to/your/api
cp .claude/settings.local.json.example .claude/settings.local.json
```

Edit `.claude/settings.local.json`:

```json
{
  "projectContext": {
    "architecture": "Layered: routes -> controllers -> services -> models",
    "database": "PostgreSQL with Prisma ORM",
    "apiVersion": "v1",
    "deploymentUrl": "https://api.your-app.example.com"
  }
}
```

---

## Step 3: Configure Server Secrets

### 3.1 Create .env

Create `.env` in project root:

```bash
# Server Configuration
NODE_ENV=development
PORT=3000
API_VERSION=v1

# Database (PostgreSQL)
DATABASE_URL=postgresql://user:password@localhost:5432/myapp_dev
DIRECT_DATABASE_URL=postgresql://user:password@localhost:5432/myapp_dev

# JWT Authentication
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_REFRESH_SECRET=your-refresh-token-secret
JWT_EXPIRES_IN=15m
JWT_REFRESH_EXPIRES_IN=7d

# Third-Party Services
STRIPE_API_KEY=sk_test_xxxxxxxxxxxxxxxxxxxxx
STRIPE_WEBHOOK_SECRET=whsec_xxxxxxxxxxxxxxxxxxxxx
SENDGRID_API_KEY=SG.xxxxxxxxxxxxxxxxxxxxx
SENDGRID_FROM_EMAIL=noreply@your-app.com

# AWS S3 (if using for file uploads)
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=AKIAXXXXXXXXXXXXX
AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxx
AWS_S3_BUCKET=your-app-uploads

# Redis (if using for caching/sessions)
REDIS_URL=redis://localhost:6379

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# CORS
CORS_ORIGIN=http://localhost:5173,https://your-app.com

# Logging
LOG_LEVEL=debug
```

**IMPORTANT**: `.env` is git-ignored. NEVER commit this file!

### 3.2 Generate Strong Secrets

```bash
# Generate JWT secret (32+ characters)
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"

# Or use OpenSSL
openssl rand -hex 32
```

---

## Step 4: Configure Database

### 4.1 Install PostgreSQL

```bash
# macOS
brew install postgresql@15
brew services start postgresql@15

# Create database
createdb myapp_dev
createdb myapp_test
```

### 4.2 Configure Prisma

Update `DATABASE_URL` in `.env`, then:

```bash
# Generate Prisma client
pnpm prisma generate

# Run migrations
pnpm prisma migrate dev

# Seed database (optional)
pnpm prisma db seed
```

### 4.3 Environment-Specific Databases

```bash
# .env.development
DATABASE_URL=postgresql://user:password@localhost:5432/myapp_dev

# .env.test
DATABASE_URL=postgresql://user:password@localhost:5432/myapp_test

# .env.production (use managed DB)
DATABASE_URL=postgresql://user:password@production-host:5432/myapp_prod
```

---

## Step 5: Reference Secrets in Code

### 5.1 Load Environment Variables

```typescript
// src/config/env.ts
import dotenv from 'dotenv';
import { z } from 'zod';

dotenv.config();

const envSchema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']),
  PORT: z.string().transform(Number),
  DATABASE_URL: z.string().url(),
  JWT_SECRET: z.string().min(32),
  JWT_REFRESH_SECRET: z.string().min(32),
  STRIPE_API_KEY: z.string().startsWith('sk_'),
  // ... more validations
});

export const env = envSchema.parse(process.env);
```

### 5.2 Use in Application

```typescript
// src/services/auth.ts
import jwt from 'jsonwebtoken';
import { env } from '../config/env';

export const generateToken = (userId: string) => {
  return jwt.sign({ userId }, env.JWT_SECRET, {
    expiresIn: '15m'
  });
};
```

---

## Step 6: Verify .gitignore Protection

Ensure `.gitignore` includes:

```gitignore
# Environment variables (NEVER commit!)
.env
.env.local
.env.*.local
.env.development
.env.production

# Database
*.db
*.sqlite

# Logs
logs/
*.log

# Build output
dist/
build/

# Dependencies
node_modules/

# Claude Code secrets
.claude/settings.local.json
.claude/**/*.local.md
*secrets*.json
*secrets*.env
*api-keys*.json

# OS
.DS_Store
```

---

## Step 7: Production Deployment

### 7.1 Environment Variables on Server

**DO NOT** copy `.env` to production server!

Instead, use your hosting provider's environment variable management:

**Heroku**:
```bash
heroku config:set JWT_SECRET=your-production-secret
heroku config:set DATABASE_URL=postgresql://...
```

**Railway**:
```bash
railway variables set JWT_SECRET=your-production-secret
```

**Docker**:
```yaml
# docker-compose.yml
services:
  api:
    environment:
      - JWT_SECRET=${JWT_SECRET}
      - DATABASE_URL=${DATABASE_URL}
```

### 7.2 Use Managed Services

For production:
- ✅ Use managed PostgreSQL (AWS RDS, Railway, Supabase)
- ✅ Use managed Redis (Redis Cloud, Upstash)
- ✅ Use secrets manager (AWS Secrets Manager, HashiCorp Vault)
- ❌ Don't use local file-based secrets

---

## Security Best Practices

### ✅ DO
- Use environment variables for ALL secrets
- Generate strong, random secrets (32+ characters)
- Use different secrets for dev/staging/prod
- Validate environment variables on startup
- Use prepared statements (Prisma does this)
- Implement rate limiting
- Hash passwords with bcrypt (min 10 rounds)
- Sanitize and validate all user input
- Use HTTPS in production
- Implement proper CORS
- Log security events
- Rotate secrets regularly

### ❌ DON'T
- Commit `.env` files to git
- Use weak or default secrets
- Expose secrets in error messages
- Trust client-side validation
- Store passwords in plain text
- Use GET requests for sensitive data
- Log sensitive information
- Disable security features in production
- Use `SELECT *` in queries
- Expose stack traces to clients

---

## Middleware Security

### Essential Security Middleware

```typescript
// src/middleware/security.ts
import helmet from 'helmet';
import rateLimit from 'express-rate-limit';
import cors from 'cors';

// Helmet (security headers)
app.use(helmet());

// CORS
app.use(cors({
  origin: env.CORS_ORIGIN.split(','),
  credentials: true
}));

// Rate limiting
const limiter = rateLimit({
  windowMs: env.RATE_LIMIT_WINDOW_MS,
  max: env.RATE_LIMIT_MAX_REQUESTS,
  message: 'Too many requests from this IP'
});
app.use('/api/', limiter);

// Body parsing (with size limits)
app.use(express.json({ limit: '10kb' }));

// Input sanitization
import mongoSanitize from 'express-mongo-sanitize';
app.use(mongoSanitize());
```

---

## Testing with Secrets

### Test Environment

```bash
# .env.test
DATABASE_URL=postgresql://user:password@localhost:5432/myapp_test
JWT_SECRET=test-secret-only-for-testing-minimum-32-chars
NODE_ENV=test
```

### Mock External Services

```typescript
// tests/setup.ts
import { vi } from 'vitest';

// Mock Stripe
vi.mock('stripe', () => ({
  default: vi.fn(() => ({
    charges: {
      create: vi.fn().mockResolvedValue({ id: 'ch_test_123' })
    }
  }))
}));
```

---

## Troubleshooting

### Environment Variables Not Loading

**Problem**: `process.env.JWT_SECRET` is undefined

**Solution**:
1. Verify `.env` file exists in project root
2. Check `dotenv` is loaded: `import 'dotenv/config'`
3. Restart server
4. Check file permissions: `ls -la .env`

### Database Connection Failed

**Problem**: Can't connect to PostgreSQL

**Solution**:
1. Verify PostgreSQL is running: `pg_isready`
2. Check `DATABASE_URL` format
3. Verify user has permissions
4. Check database exists: `psql -l`

### JWT Verification Failed

**Problem**: Token verification fails

**Solution**:
1. Ensure same `JWT_SECRET` for sign and verify
2. Check token hasn't expired
3. Verify token format: `eyJhbGci...`
4. Check for whitespace in secret

---

## Security Checklist

- [ ] All secrets in `.env` (not in code)
- [ ] `.gitignore` includes `.env` and all secret patterns
- [ ] Environment variables validated on startup (Zod)
- [ ] Strong JWT secrets (32+ characters, random)
- [ ] Different secrets for dev/staging/prod
- [ ] Helmet middleware enabled
- [ ] CORS configured properly
- [ ] Rate limiting implemented
- [ ] Input validation and sanitization
- [ ] Passwords hashed with bcrypt
- [ ] SQL injection prevention (Prisma)
- [ ] HTTPS in production
- [ ] Error messages don't expose secrets
- [ ] Logging doesn't include sensitive data
- [ ] Security headers configured

---

## Additional Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Express Security Best Practices](https://expressjs.com/en/advanced/best-practice-security.html)
- [Prisma Security](https://www.prisma.io/docs/guides/security)
- [JWT Best Practices](https://tools.ietf.org/html/rfc8725)

---

**Last Updated**: 2025-11-17 (Phase 3)
