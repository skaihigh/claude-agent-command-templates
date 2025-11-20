---
description: Research technology option and provide recommendation
allowed-tools: [WebFetch, Read, Write]
---

Research technology: $ARGUMENTS

Perform comprehensive research and analysis:

1. **Technology Overview**
   - What is it and what problem does it solve?
   - Current version and release history
   - Popularity and community size (GitHub stars, npm downloads)

2. **Project Fit**
   - How does it address your specific needs?
   - Compatibility with your tech stack (check .claude-templates.config.json if available)
   - Bundle size impact (gzipped)
   - Browser support (based on your target browsers)

3. **Evaluation Criteria** (from docs/TECHNOLOGY.md)
   - **Performance**: Speed, bundle size, memory usage
   - **Developer Experience**: Documentation, community, ease of integration
   - **Maintenance**: Active development, long-term support, stability
   - **Compatibility**: Browser support, mobile devices, offline functionality
   - **Cost**: Licensing, hosting, third-party service fees

4. **Alternatives**
   - List 2-3 alternative solutions
   - Compare features, pros/cons
   - Provide recommendation with rationale

5. **Implementation Plan**
   - Installation steps
   - Configuration requirements
   - Integration approach
   - Potential challenges

6. **Decision**
   - Clear recommendation: ✅ Adopt / ⚠️  Evaluate further / ❌ Reject
   - Rationale based on evaluation criteria
   - Next steps if adopting

Output a structured research document that can be saved to docs/ for future reference.
