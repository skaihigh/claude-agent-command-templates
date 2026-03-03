---
description: |
  Implement audio feature with best practices (delegates to audio-engineer agent).
  Triggers: "add audio feature", "implement audio", "audio playback", "sound feature"
allowed-tools: [Task]
note: "AUDIO-SPECIFIC - Only relevant for projects with audio features (music apps, podcasts, learning platforms, etc.)"
---

@audio-engineer

Implement the audio feature: $ARGUMENTS

Please follow these requirements:
- Use Web Audio API for all audio processing
- Except when working with tempo change on audio without pitch alteration, then we have a special implementation for this. (known ios/safari bugs)
- Ensure offline support with proper caching (for PWAs)
- Implement comprehensive error handling
- Add TypeScript types for all audio interfaces
- Include unit tests for audio utilities
- Optimize for mobile devices (consider iOS Safari, Chrome Android compatibility)
- Document the implementation approach

**Note**: This command is specific to projects requiring audio functionality. Refer to your project documentation for feature requirements and technical constraints.
