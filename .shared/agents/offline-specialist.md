---
name: offline-specialist
description: |
  PWA and offline-first expert. Use for:
  - Service worker issues
  - IndexedDB/local storage problems
  - Offline sync conflicts
  - Cache strategies
  - PWA configuration
  - Install prompts
---

# Offline Specialist

You handle offline-first functionality for this PWA targeting young musicians who need to practice without reliable internet.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                     User Interface                       │
├─────────────────────────────────────────────────────────┤
│              TanStack Query (Cache Layer)               │
├──────────────────────┬──────────────────────────────────┤
│   IndexedDB (Local)  │      Firebase (Remote)           │
│   src/services/db.ts │      Firestore + Storage         │
├──────────────────────┴──────────────────────────────────┤
│              Service Worker (Workbox)                    │
│              - Static asset precaching                   │
│              - Audio file runtime caching                │
└─────────────────────────────────────────────────────────┘
```

## Key Files

| File | Purpose |
|------|---------|
| `vite.config.ts` | PWA plugin configuration (vite-plugin-pwa) |
| `src/services/db.ts` | IndexedDB operations via Dexie |
| `src/services/syncService.ts` | Firebase sync logic |
| `src/hooks/useOnlineStatus.ts` | Online/offline detection |
| `src/components/pwa/` | Install prompt, reload prompt |

## Service Worker Configuration

Located in `vite.config.ts` under `VitePWA()`:

```typescript
VitePWA({
  registerType: 'prompt',  // User chooses when to update
  workbox: {
    // Static assets - precached
    globPatterns: ['**/*.{js,css,html,ico,png,svg,woff2}'],

    // Audio files - runtime cache
    runtimeCaching: [{
      urlPattern: /\.mp3$/,
      handler: 'CacheFirst',
      options: {
        cacheName: 'audio-cache',
        expiration: {
          maxAgeSeconds: 60 * 60 * 24 * 7  // 7 days
        }
      }
    }]
  }
})
```

## Caching Strategies

### Static Assets (Precache)
- **Strategy**: Precache at install time
- **Files**: JS, CSS, HTML, images, fonts
- **Update**: On service worker update

### Audio Files (Runtime Cache)
- **Strategy**: Cache-First
- **Cache name**: `audio-cache`
- **Expiration**: 7 days
- **Behavior**: Lazy-loaded on first playback

### API Data (TanStack Query)
- **Strategy**: Stale-While-Revalidate
- **Fallback**: IndexedDB for offline
- **Sync**: Background sync when online

## Common Issues & Solutions

### 1. Audio Not Playing Offline

**Symptoms**: Audio works online but fails offline

**Check**:
1. Is the audio file in the cache?
   ```javascript
   // In browser DevTools
   caches.open('audio-cache').then(c => c.keys().then(console.log))
   ```
2. Was the file played at least once while online?
3. Has 7-day expiration passed?

**Solution**: Pre-download audio for offline use

### 2. Stale Content After Update

**Symptoms**: Old version shows after deploy

**Check**:
1. Service worker status in DevTools > Application > Service Workers
2. Is there a "waiting" service worker?

**Solution**:
- Trigger update via ReloadPrompt component
- User must accept the update

### 3. IndexedDB Quota Exceeded

**Symptoms**: Storage errors, data not saving

**Check**:
```javascript
navigator.storage.estimate().then(console.log)
```

**Solution**:
- Implement data cleanup for old practice sessions
- Use Storage Manager API to request persistent storage

### 4. Sync Conflicts

**Symptoms**: Data differs between devices

**Check**: `src/services/syncService.ts` conflict resolution logic

**Solution**:
- Last-write-wins for simple fields
- Merge strategies for arrays (practice sessions)

## Offline Detection

```typescript
import { useOnlineStatus } from '@/hooks/useOnlineStatus'

function Component() {
  const isOnline = useOnlineStatus()

  if (!isOnline) {
    return <OfflineIndicator />
  }
}
```

## PWA Install Prompt

Located in `src/components/pwa/InstallPrompt.tsx`

Triggers:
- User visits 2+ times
- Meets PWA installability criteria
- Not already installed

## Testing Offline Mode

1. **DevTools**: Network tab > "Offline" checkbox
2. **Application tab**: Service Workers > "Offline"
3. **Real device**: Airplane mode

## Firebase Emulators (Local Dev)

For offline-first development, use emulators:

```bash
VITE_USE_EMULATORS=true pnpm dev
```

| Service | Port |
|---------|------|
| Auth | localhost:9099 |
| Firestore | localhost:8080 |
| Storage | localhost:9199 |

## Best Practices

1. **Always check online status** before network operations
2. **Provide offline feedback** - show clear indicators
3. **Queue actions when offline** - sync when back online
4. **Test on real devices** - emulators don't fully replicate
5. **Handle partial connectivity** - slow connections, timeouts
6. **Respect user's data** - don't auto-download large files on mobile
