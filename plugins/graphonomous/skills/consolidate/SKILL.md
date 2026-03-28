---
name: consolidate
description: Use at end of productive sessions, after heavy storage bursts, periodically during long iterations, or when the user says "consolidate", "maintain graph", "clean up memory".
---

# Consolidation

Trigger graph maintenance — decay weak knowledge, prune, merge duplicates, strengthen relationships.

## Trigger Consolidation

```
run_consolidation(action: "run_and_status", wait_ms: 2000)
```

**Actions:**
- `run` — fire-and-forget
- `status` — check current state
- `run_and_status` — trigger + wait + report (recommended)

## What Consolidation Does (7-stage pipeline)

1. **Decay** — reduce confidence of stale knowledge over time
2. **Prune nodes** — remove nodes below confidence threshold
3. **Prune edges** — remove edges below weight threshold
4. **Strengthen** — boost co-activated edges (nodes retrieved together)
5. **Merge** — combine near-duplicate nodes (similarity > 0.95)
6. **Promote** — move valuable knowledge to slower decay timescales
7. **Abstract** — generate semantic summaries from episodic clusters

## When to Consolidate

- End of every productive session
- Every 4–5 heavy storage/learning iterations
- After outcome learning bursts
- Before critical retrievals (ensures clean graph)

## Health Indicators

After consolidation, check:
- Node count growing steadily? Good.
- Some nodes pruned? Healthy decay.
- Occasional merges? Deduplication working.
- Edge/node ratio 0.5–3.0? Balanced connectivity.

Consolidation also runs automatically during idle — manual triggers supplement this.
