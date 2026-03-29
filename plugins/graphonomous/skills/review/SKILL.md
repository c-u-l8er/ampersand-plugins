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
    "supporting_evidence_count": 5,
    "coverage_estimate": 0.7
  },
  apply_decision: true
)
```

**Returns:** `decision` (act/learn/escalate), `coverage_score`, `uncertainty_score`, `risk_score`, `rationale`, `applied_review`, `transition` (if apply_decision was true), `evaluation`.

## Decision Policy

- **act** → coverage adequate, proceed with execution
- **learn** → gaps exist, gather more info, then re-review
- **escalate** → critically low coverage or high risk, mark blocked, get external help

If `apply_decision: true`, the goal auto-transitions: act → active, learn → proposed, escalate → blocked.

## Tuning Options

Pass `options` to customize evaluation thresholds:

```
review_goal(
  goal_id: "<id>",
  signal: { ... },
  options: {
    "top_k": 10,
    "min_context_nodes": 3,
    "freshness_half_life_hours": 48,
    "graph_support_target": 0.6,
    "weights": {"coverage": 0.4, "confidence": 0.3, "freshness": 0.2, "support": 0.1},
    "thresholds": {"act": 0.7, "learn": 0.4}
  }
)
```

- `top_k` — how many top nodes to consider for scoring
- `min_context_nodes` — minimum linked nodes needed for adequate coverage
- `freshness_half_life_hours` — decay rate for old evidence
- `graph_support_target` — target ratio of supporting edges
- `weights` — custom scoring dimension weights
- `thresholds` — custom decision boundaries (above act threshold = act, below learn threshold = escalate)

## Building Honest Signals

Build the `signal` from REAL retrieval data — never fabricate:

1. **Always retrieve first** — run `retrieve_context` before building the signal
2. `retrieved_nodes` — from actual results (include node_id, confidence, similarity)
3. `outcomes` — from actual `learn_from_outcome` calls (include action_id, status, confidence)
4. `contradictions` — count `contradicts` edges found during inspection
5. `knowledge_gaps` — questions the graph couldn't answer
6. `supporting_evidence_count` — number of `supports` edges found
7. `coverage_estimate` — your honest assessment (0.0–1.0)

## Standalone Coverage Query (No Goal Required)

For quick coverage assessment without a goal:

```
coverage_query(query: "auth middleware token validation", limit: 10, expansion_hops: 1)
```

Returns coverage score, decision (act/learn/escalate), relevant nodes, and confidence stats. Use this when you want a fast coverage check without creating or linking to a goal.

**`coverage_query` vs `review_goal`:**
| | `coverage_query` | `review_goal` |
|---|---|---|
| **Requires goal** | No | Yes |
| **Requires signal** | No (auto-retrieves) | Yes (you build the signal) |
| **State transitions** | None | Optional (apply_decision) |
| **Use when** | Quick pre-action check | Formal goal-driven review |

## Workflow Patterns

### Pre-action gate
Retrieve → build signal → review → if `act`, proceed; if `learn`, gather more; if `escalate`, block.

### Iterative review loop
After a `learn` decision: retrieve more → store findings → re-review → eventually reach `act` or `escalate`.

### Post-failure review
After `learn_from_outcome(status: "failure")`: re-review the goal to reassess coverage with the new negative signal.

### High-stakes review (strict thresholds)
```
review_goal(goal_id: "<id>", signal: { ... }, options: {"thresholds": {"act": 0.85, "learn": 0.5}})
```

### Informational review (no state transition)
```
review_goal(goal_id: "<id>", signal: { ... }, apply_decision: false)
```
Check coverage without changing goal status.

## Anti-patterns to avoid
- Signal fabrication — building signals from made-up data instead of real retrieval
- Review theater — calling review_goal but ignoring the act/learn/escalate decision
- Skipping review before high-stakes actions
