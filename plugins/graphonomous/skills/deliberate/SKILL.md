---
name: deliberate
description: Use when retrieve_context returns routing "deliberate", when κ > 0 is detected, before high-stakes decisions with cyclic knowledge, or when the user asks to "deliberate", "reason through cycles", "resolve contradictions".
argument-hint: <question or decision to deliberate on>
---

# Topology and Deliberation

Detect and reason through circular dependencies (cycles) in knowledge.

## Key Concepts

**κ (kappa)** is the cycle-complexity invariant — it measures how entangled the knowledge is:
- **κ = 0** — acyclic DAG, no cycles. Safe for fast retrieval.
- **κ = 1** — simple cycle (A→B→C→A). Deliberation may help for high-stakes decisions.
- **κ = 2+** — nested/overlapping cycles. Deliberation strongly recommended.

**SCCs (Strongly Connected Components)** are maximal cyclic clusters — groups of nodes where every node can reach every other node through directed edges.

**Fault-line edges** are the weakest links in a cycle — the assumptions most likely to be wrong. Examining these first is the fastest path to resolving contradictions.

## Arguments

Question to deliberate: $ARGUMENTS

## Analyze Topology

Read-only diagnostic — understand the structure:

```
topology_analyze(query: "<topic>")
```

**Parameters:**
- `node_ids` (optional) — explicit array of node IDs to analyze
- `query` (optional) — retrieve nodes by query, then analyze
- Neither → analyzes full graph

If both `node_ids` and `query` are provided, `node_ids` takes precedence.

**Response fields:**
- `routing` — `"fast"` or `"deliberate"`
- `max_kappa` — highest κ value found
- `sccs` — array of strongly connected components, each with its own `routing` and `kappa`
- `fault_line_edges` — weakest edges in cycles (examine these first)
- `deliberation_budget` — `max_iterations` and `focus_edges` to guide deliberation effort
- `recommendation` — human-readable guidance
- `selection` — how nodes were resolved (explicit/query/full_graph)
- `approximate` — whether analysis used approximation for large graphs

## Deliberate Through Cycles

Reason through cyclic knowledge and optionally persist conclusions:

```
deliberate(
  query: "Should we use approach A or B given the conflicting evidence?",
  node_ids: ["<node1>", "<node2>"],
  write_back: true
)
```

**Response fields:**
- `conclusions` — array of resolved conclusions, each with `source_scc_id`, `source_kappa`, `fault_lines_examined`
- `deliberation.converged` — whether deliberation reached stable conclusions
- `deliberation.iterations_used` — how many reasoning passes were needed
- `deliberation.topology_change` — `kappa_before`, `kappa_after`, `new_nodes_created`

### When to use `write_back`

- `write_back: true` — crystallizes conclusions as new nodes. Use when you've reached a resolution you want to persist (reduces κ for future retrievals).
- `write_back: false` — reasoning only, no graph changes. Use for exploration or when you're not confident in the conclusion yet.

## Full Workflow

1. **Detect** — `retrieve_context` returns `topology.routing: "deliberate"`
2. **Diagnose** — `topology_analyze(query: "...")` for detailed cycle info and fault-lines
3. **Examine fault-lines** — inspect the weakest edges identified in step 2
4. **Deliberate** — `deliberate(query: "...", write_back: true)` to reason through and resolve
5. **Verify** — re-run `topology_analyze` to confirm κ decreased after resolution

## When NOT to deliberate
- When `routing: "fast"` — normal retrieval is sufficient
- For low-stakes decisions — deliberation has a cost
- When there are no cycles (κ = 0) — nothing to deliberate about
- Over-deliberation is an anti-pattern — only deliberate when routing recommends it or you suspect contradictions
