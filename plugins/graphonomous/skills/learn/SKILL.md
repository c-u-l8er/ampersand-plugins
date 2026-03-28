---
name: learn
description: Use after completing a consequential action informed by retrieved knowledge. Reports outcomes to update confidence in the knowledge graph. Use when the user says "report outcome", "learn from this", "update confidence", or after any action that used retrieved context.
argument-hint: <action-description> <success|failure|partial_success|timeout>
---

# Learning Loop

Close the feedback loop so the graph learns what works and what doesn't.

## Arguments

Action and status: $ARGUMENTS

## Report an Outcome

```
learn_from_outcome(
  action_id: "descriptive-slug-of-what-you-did",
  status: "success",
  confidence: 0.8,
  causal_node_ids: ["<id1>", "<id2>"]
)
```

**Required fields:**
- `action_id` — descriptive slug of the action taken
- `status` — one of: `success`, `partial_success`, `failure`, `timeout`
- `confidence` — 0.0–1.0, reliability of this feedback signal (NOT the original decision quality)
- `causal_node_ids` — from `causal_context` saved during retrieval

**Status meanings:**
- `success` → boosts confidence of causal nodes
- `failure` → reduces confidence of causal nodes
- `partial_success` → small boost
- `timeout` → minimal change (NOT the same as failure!)

**Include evidence when practical:**
```
learn_from_outcome(
  action_id: "fix-auth-middleware",
  status: "success",
  confidence: 0.9,
  causal_node_ids: ["node-abc", "node-def"],
  evidence: {"test_passed": true, "error_resolved": true}
)
```

## Pattern

1. `retrieve_context(query: "...")` → save `causal_context`
2. Act on retrieved knowledge
3. `learn_from_outcome(...)` with real causal IDs and honest status

## Anti-patterns to avoid
- Fire and forget (never reporting outcomes)
- Using `failure` when you mean `timeout`
- Fabricating causal node IDs
- Setting confidence to 1.0 on every outcome
