---
name: forgetting
description: Use when nodes need to be removed from the knowledge graph — soft-hide from retrieval, hard-delete, cascade-delete orphans, GDPR-erase with audit, or run budget-aware priority pruning. Use when the user says "forget this", "delete node", "clean up", "GDPR erase", "prune low-priority", or "run forgetting policy".
argument-hint: <soft|hard|cascade|gdpr|policy> [node_id]
---

# Intentional Forgetting — Structured Knowledge Removal

Four forgetting modes plus budget-aware policy pruning.

## Arguments

Mode and target: $ARGUMENTS

## Forgetting Modes

### Soft Forget — Hide from Retrieval

```
forget_node(node_id: "<id>", mode: "soft", reason: "Outdated reference")
```

Response: `{status: "ok", node_id, mode: "soft", reason: null}`

Note: `reason` is always null in response (server doesn't echo it back). Node gets `forgotten_at` timestamp internally, excluded from retrieval, but structure/edges preserved. Reversible.

### Hard Forget — Delete Node + Edges

```
forget_node(node_id: "<id>", mode: "hard")
```

Response: `{status: "ok", node_id, mode: "hard", reason: null}`

UtU-style constant-time unlink: severs all edges, deletes node. Irreversible.

### Cascade Forget — Delete + Orphaned Dependents

```
forget_node(node_id: "<id>", mode: "cascade", reason: "Removing stale test data")
```

Response: `{status: "ok", node_id, mode: "cascade", reason: "cascaded N"}`

Where N = number of orphaned dependents also deleted. Orphans = nodes whose ONLY incoming support was from the deleted node.

### GDPR Erase — Permanent Audit-Logged Deletion

```
gdpr_erase(node_id: "<id>")
```

Response: `{status: "erased", node_id, audit: {node_type, reason: "gdpr_erase", node_id, erased_at}}`

Permanently removes node, all edges, and embedding data. Audit-logged per GDPR Article 17. No recovery possible.

## Budget-Aware Policy Pruning

Preview what would be forgotten:

```
forget_by_policy(dry_run: true, max_nodes: 500)
```

Response: `{status: "ok", forgotten_count: 0, surviving_count: N, would_forget: M, candidates: [{node_id, priority_score}]}`

Execute the policy:

```
forget_by_policy(max_nodes: 500)
```

Response: `{status: "ok", forgotten_count: M, surviving_count: N}`

Priority scoring: `confidence × recency × (1 + log(access_count + 1)) × (1 + connectivity)`. Lowest-priority nodes forgotten first via soft-forget.

## When to Use Which

| Scenario | Mode |
|----------|------|
| Outdated but might be useful later | `soft` |
| Definitely wrong, no dependents | `hard` |
| Wrong + has orphaned dependents | `cascade` |
| Contains PII / user data | `gdpr_erase` |
| Graph getting too large | `forget_by_policy` |
| Want to weaken, not remove | Use `belief_revise(contract)` instead |

## Anti-Patterns

- Don't GDPR-erase non-PII nodes — use soft/hard instead
- Don't forget without checking dependents — use cascade if unsure
- Always dry_run policy before executing
- Don't forget nodes that are part of active goals — check goal linkage first
