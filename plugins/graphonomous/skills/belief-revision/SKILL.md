---
name: belief-revision
description: Use when knowledge changes, contradictions are detected, facts become outdated, or corrections are needed. Handles AGM-rational expand/revise/contract operations with automatic contradiction detection. Use when the user says "revise belief", "check contradictions", "correct this fact", "this is outdated", or "expand knowledge".
argument-hint: <expand|revise|contract> [node_id] [content]
---

# Belief Revision — AGM-Rational Knowledge Updates

Structured belief management: expand (add new), revise (supersede old), contract (withdraw).

## Arguments

Operation and context: $ARGUMENTS

## The Three Operations

### Expand — Add a New Belief

```
belief_revise(
  operation: "expand",
  content: "The API rate limit is 1000 req/min per tenant",
  confidence: 0.8,
  rationale: "Confirmed in infrastructure docs"
)
```

Response: `{status, node_id, revision_id, contradictions: [{node_id, similarity, confidence, content_preview}], contradiction_edges}`

If contradictions are returned, decide: **revise** the old node, **deliberate** if both might be correct, or **leave both** if the contradiction is productive.

### Revise — Replace a Belief

```
belief_revise(
  operation: "revise",
  node_id: "<old_node_id>",
  content: "Updated fact with new information",
  confidence: 0.85,
  rationale: "Why the old belief is wrong"
)
```

Response: `{status, revision_id, old_node_id, new_node_id, affected_node_ids}`

Internally: creates new node, marks old as superseded (confidence × 0.3), creates `:superseded_by` edge, propagates 0.6× confidence decay through dependent nodes.

### Contract — Withdraw a Belief

```
belief_revise(
  operation: "contract",
  node_id: "<node_id>",
  rationale: "Why this belief should be withdrawn"
)
```

Response: `{status, node_id, revision_id, affected_node_ids}`

Sets confidence to 0.05, propagates decay. Node preserved for provenance (not deleted).

## Detecting Contradictions

Check proactively — don't wait for expand to find them:

```
belief_contradictions(node_id: "<node_id>")
belief_contradictions(content: "Some claim to check")
```

Response: `{count, status, node_id, contradictions: [{node_id, similarity, confidence, content_preview}]}`

Detection uses: semantic similarity ≥ 0.75, negation markers ("not", "incorrect", "outdated", "replaced", etc.), confidence divergence.

## Workflow

1. **Detect** → `belief_contradictions(content: "<new information>")`
2. **Assess** → Are contradictions real? Check context, recency, source quality
3. **Decide** → Revise old? Contract old? Expand alongside? Deliberate?
4. **Act** → `belief_revise(operation: "revise/contract/expand", ...)`
5. **Verify** → `topology_analyze()` to check if new SCCs formed
6. **Learn** → `learn_from_outcome` on the revision action

## Anti-Patterns

- **Revise without checking** — always run `belief_contradictions` first
- **Expand when you should revise** — if old belief is wrong, revise it
- **Skip outcome learning** — always report belief revision outcomes
