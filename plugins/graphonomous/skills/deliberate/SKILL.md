---
name: deliberate
description: Use when retrieve_context returns routing "deliberate", when κ > 0 is detected, before high-stakes decisions with cyclic knowledge, or when the user asks to "deliberate", "reason through cycles", "resolve contradictions".
argument-hint: <question or decision to deliberate on>
---

# Topology and Deliberation

Detect and reason through circular dependencies (cycles) in knowledge. κ (kappa) measures cycle complexity.

## Arguments

Question to deliberate: $ARGUMENTS

## Analyze Topology

Read-only diagnostic — understand the structure:

```
topology_analyze(query: "<topic>")
```

Returns: `routing` (fast/deliberate), `max_kappa`, SCCs (strongly connected components), fault-line edges, deliberation budget.

- **κ = 0** → no cycles, safe for normal retrieval
- **κ > 0** → cycles detected, deliberation recommended for high-stakes decisions

## Deliberate Through Cycles

Reason through cyclic knowledge and optionally persist conclusions:

```
deliberate(
  query: "Should we use approach A or B given the conflicting evidence?",
  node_ids: ["<node1>", "<node2>"],
  write_back: true
)
```

Returns: conclusions, topology change (κ before/after), convergence status.

`write_back: true` crystallizes conclusions as new nodes in the graph.

## Workflow

1. **Detect** — `retrieve_context` returns `topology.routing: "deliberate"`
2. **Diagnose** — `topology_analyze` for detailed cycle info
3. **Deliberate** — `deliberate(query: "...")` to reason through
4. **Resolve** — conclusions stored (if `write_back`), re-check topology

## When NOT to deliberate
- When `routing: "fast"` — normal retrieval is sufficient
- For low-stakes decisions
- When there are no cycles (κ = 0)
