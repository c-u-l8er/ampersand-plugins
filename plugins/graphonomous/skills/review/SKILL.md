---
name: review
description: Use before high-stakes actions, after learning phases, after outcome failures, or when the user asks "do we know enough?", "should we proceed?", "review coverage". Epistemic self-modeling — decides act/learn/escalate.
argument-hint: <goal_id>
---

# Coverage and Review

Evaluate whether you know enough to act on a goal, or need to learn more.

## Arguments

Goal to review: $ARGUMENTS

## Review Coverage

```
review_goal(
  goal_id: "<id>",
  signal: {
    "retrieved_nodes": [{"node_id": "abc", "confidence": 0.8, "similarity": 0.85}],
    "outcomes": [{"action_id": "fix-auth", "status": "success", "confidence": 0.9}],
    "contradictions": 0,
    "knowledge_gaps": ["How does the rate limiter interact with auth?"],
    "coverage_estimate": 0.7
  },
  apply_decision: true
)
```

**Returns:** `decision` (act/learn/escalate), `coverage_score`, `uncertainty_score`, `risk_score`, `rationale`

## Decision Policy

- **act** → coverage adequate, proceed with execution
- **learn** → gaps exist, gather more info, then re-review
- **escalate** → critically low coverage or high risk, mark blocked, get external help

If `apply_decision: true`, the goal auto-transitions: act → active, learn → proposed, escalate → blocked.

## Building Honest Signals

Build the `signal` from REAL data:
- `retrieved_nodes` — from actual `retrieve_context` results
- `outcomes` — from actual `learn_from_outcome` calls
- `contradictions` — count of `contradicts` edges found
- `knowledge_gaps` — questions the graph couldn't answer
- `coverage_estimate` — your honest assessment (0.0–1.0)

**Never fabricate signals.** If you haven't retrieved, don't guess.

## When to Review
- Before committing to a major action
- After a `learn` phase completes
- After an outcome failure
- Periodically during long execution (every 4–5 actions)
