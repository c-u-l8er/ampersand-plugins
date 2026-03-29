---
name: bootstrap
description: Use when starting a new session, switching topics, or when the user says "bootstrap", "start session", "initialize graphonomous", or "load memory". Activates the Graphonomous-first memory loop and orients on prior context.
---

# Graphonomous Bootstrap

Initialize the Graphonomous-first memory loop for this session.

## Steps

1. **Retrieve prior context** for the user's current topic:
   ```
   retrieve_context(query: "summary of prior work on <topic>")
   ```

2. **Check active goals** to regain session continuity:
   ```
   manage_goal(operation: "list_goals", filters: {"status": "active"})
   ```

3. **Survey attention** to see what needs focus:
   ```
   attention_survey(include_idle: false)
   ```

4. **Adopt the policy**: "Graphonomous-first memory loop is active."

5. **Report** to the user: what prior context exists, which goals are active, and what the attention engine recommends focusing on.

## Core Loop (apply for remainder of session)

For every non-trivial task, run this loop by default:

1. **Retrieve first** — `retrieve_context` before reasoning/acting. Never skip for domain-specific work.
2. **Reason and act** — use retrieved context + conversation to inform decisions
3. **Store new knowledge** — `store_node` for durable atomic facts/procedures/events; `store_edge` only when the relationship genuinely improves retrieval
4. **Close the loop** — `learn_from_outcome` whenever you have an outcome signal for a consequential action. Preserve `causal_context` between retrieval and outcome.
5. **Maintain** — `run_consolidation` periodically and at session end

## Node and Edge Discipline

- Prefer **small, atomic nodes** — one fact/procedure/event per node
- Choose node types correctly: `semantic` (facts), `procedural` (how-to), `episodic` (events)
- Set confidence based on evidence quality, not optimism
- Include `source` whenever possible (file path, URL, "conversation")
- Create edges only when they improve retrieval: `causal`, `supports`, `contradicts`, `related`, `derived_from`

## Hard Prohibitions

Do NOT:
- Skip retrieval habitually — prior context likely exists
- Skip outcome learning on consequential actions
- Inflate confidence indiscriminately (no blanket 0.9+)
- Store kitchen-sink nodes (multiple unrelated facts)
- Fabricate coverage signals or causal provenance
- Ignore repeated `learn`/`escalate` decisions from coverage review
- Create edge spaghetti (link everything to everything)
- Neglect consolidation indefinitely

## Available Resources (Read-Only Snapshots)

| URI | What It Returns |
|-----|----------------|
| `graphonomous://runtime/health` | Runtime health, service status, counts |
| `graphonomous://goals/snapshot` | Goal totals and status breakdown |
| `graphonomous://graph/node/{id}` | Individual node details + edges |
| `graphonomous://graph/recent` | Recently accessed nodes |
| `graphonomous://consolidation/log` | Consolidator + orchestrator metrics |

## Extended Tool Surface

Beyond the core loop tools, these specialized tools are available:
- **`graph_traverse`** — BFS walk from a node with depth/relationship filters
- **`graph_stats`** — aggregate graph health (counts, distributions, orphans)
- **`retrieve_episodic`** — time-range filtered episodic node retrieval
- **`retrieve_procedural`** — semantic search scoped to procedural (how-to) nodes
- **`coverage_query`** — standalone epistemic coverage check (no goal required)
- **`learn_from_feedback`** — process positive/negative/correction on a node
- **`learn_detect_novelty`** — check if a concept is novel to the graph
- **`learn_from_interaction`** — full learning pipeline for user-model exchanges

## Session End Checklist

Before ending a productive session:
1. Store key new knowledge discovered via `store_node`
2. Report pending outcomes via `learn_from_outcome`
3. Update goal progress via `manage_goal`
4. Trigger `run_consolidation(action: "run_and_status", wait_ms: 2000)`
