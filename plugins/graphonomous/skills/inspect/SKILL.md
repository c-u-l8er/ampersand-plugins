---
name: inspect
description: Use when the user asks to "show the graph", "list nodes", "what's stored", "check for duplicates", "trace edges", or wants to audit/browse the knowledge graph. Read-only graph inspection.
argument-hint: [list|get|edges|search] [query or node_id]
---

# Graph Inspection

Read-only inspection of the knowledge graph — no side effects.

## Arguments

Operation and target: $ARGUMENTS

## Operations

### List nodes
```
query_graph(operation: "list_nodes", node_type: "semantic", min_confidence: 0.5, limit: 20)
```
Browse what's stored. Filter by `node_type`, `min_confidence`, `max_confidence`, `limit`.

### Get a specific node
```
query_graph(operation: "get_node", node_id: "<id>")
```
Returns: `content`, `confidence`, `source`, `metadata`, `node_type`, `timescale` (fast/medium/slow/glacial), `access_count`, `created_at`, `updated_at`.

### Trace edges from a node
```
query_graph(operation: "get_edges", node_id: "<id>")
```
Returns both outgoing and incoming edges with types and weights. Useful for tracing causal chains, finding contradictions, and understanding provenance.

### Similarity search
```
query_graph(operation: "similarity_search", query: "<text>", limit: 5)
```
Embedding-based search. Returns nodes with similarity scores.

**Operation aliases:** `"get"`, `"edges"`, `"list"` also work as shorthand.

## `retrieve_context` vs `similarity_search`

| | `retrieve_context` | `query_graph(similarity_search)` |
|---|---|---|
| **Neighborhood expansion** | Yes (hops) | No |
| **Topology annotations** | Yes (routing, κ) | No |
| **Causal context** | Yes (for outcome learning) | No |
| **Side effects** | Updates access counts | None |
| **Use when** | Acting on results (need causal tracking) | Checking duplicates, auditing, browsing |

**Rule:** Use `retrieve_context` when you plan to act on results. Use `similarity_search` for read-only inspection.

## Common Patterns

### Duplicate prevention (check before storing)
```
query_graph(operation: "similarity_search", query: "the fact I want to store", limit: 3)
```
- similarity > 0.90 → **duplicate** — update the existing node instead
- similarity 0.70–0.90 → **related** — store new node + add `related` edge
- similarity < 0.70 → **novel** — safe to store as new node

### Audit weak knowledge
```
query_graph(operation: "list_nodes", min_confidence: 0.0, max_confidence: 0.3)
```
Find speculative or likely-wrong nodes needing reinforcement or pruning.

### Trace decision chains
```
query_graph(operation: "get_node", node_id: "<id>")
query_graph(operation: "get_edges", node_id: "<id>")
```
Follow `causal` and `supports` edges to reconstruct reasoning. Check for `contradicts` edges that indicate unresolved conflicts.

### Verify before trusting
After retrieval returns a high-confidence node, trace its edges to find supporting/contradicting evidence before acting on it.
