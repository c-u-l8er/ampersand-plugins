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
Browse what's stored. Filter by type and confidence.

### Get a specific node
```
query_graph(operation: "get_node", node_id: "<id>")
```
Returns content, confidence, source, metadata, access count.

### Trace edges from a node
```
query_graph(operation: "get_edges", node_id: "<id>")
```
Returns both outgoing and incoming edges. Useful for tracing causal chains and finding contradictions.

### Similarity search (check for duplicates)
```
query_graph(operation: "similarity_search", query: "<text>", limit: 5)
```
Embedding-based search. Similarity > 0.90 = likely duplicate. Use this before `store_node` to avoid duplicate flooding.

## Common workflows

**Audit weak knowledge:**
```
query_graph(operation: "list_nodes", min_confidence: 0.0, max_confidence: 0.3)
```

**Find all procedural knowledge:**
```
query_graph(operation: "list_nodes", node_type: "procedural")
```

**Check before storing:**
```
query_graph(operation: "similarity_search", query: "the fact I want to store")
```
If similarity > 0.90, update the existing node instead of creating a duplicate.
