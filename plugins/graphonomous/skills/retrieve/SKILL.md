---
name: retrieve
description: Use when the user asks to "remember", "recall", "search memory", "what do we know about", "retrieve context", or before any domain-specific action. The foundational read/write loop for Graphonomous knowledge.
argument-hint: <query>
---

# Retrieve and Remember

Search the knowledge graph and store new knowledge.

## Arguments

Query to search for: $ARGUMENTS

## Retrieve Context

Search memory by natural language query:

```
retrieve_context(query: "<query>", limit: 10, expansion_hops: 1)
```

**Important:** Save the `causal_context` from the response — you need it for `learn_from_outcome` later.

**Filters available:**
- `node_type`: "semantic", "procedural", "episodic"
- `min_score`: 0.0–1.0 (similarity threshold)
- `expansion_hops`: 0–2 (neighborhood expansion)

**Watch for:** `topology.routing` — if it says `"deliberate"`, the knowledge has cycles (use `/graphonomous:deliberate`).

## Store New Knowledge

After acting on retrieved context, store what you learned:

```
store_node(content: "<one atomic fact>", node_type: "semantic", confidence: 0.7, source: "conversation")
```

**Node types:**
- `semantic` — facts, definitions, architecture ("what is?")
- `procedural` — workflows, how-to, recipes ("how to?")
- `episodic` — events, observations, outcomes ("what happened?")

**Confidence calibration:**
- 0.9–1.0: Directly observed in code/docs
- 0.7–0.89: Strong evidence, not directly verified
- 0.5–0.69: Single source, plausible
- 0.3–0.49: Indirect evidence, uncertain
- 0.0–0.29: Speculative

## Link Knowledge

Connect related nodes when it improves retrieval:

```
store_edge(source_id: "<id>", target_id: "<id>", edge_type: "supports", weight: 0.8)
```

Edge types: `causal`, `supports`, `contradicts`, `related`, `derived_from`

## Anti-patterns to avoid
- Skipping retrieval before acting (amnesia agent)
- Storing kitchen-sink nodes with multiple facts
- Discarding `causal_context` from retrieval
- Setting all confidence to 0.9+
