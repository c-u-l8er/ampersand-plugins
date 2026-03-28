---
name: attention
description: Use at session startup to regain context, for goal selection and prioritization, when the user asks "what should I focus on?", "what needs attention?", "prioritize goals", or for periodic status reporting.
argument-hint: [survey|cycle] [observe|advise|act]
---

# Attention Engine

Autonomous focus management — rank goals by urgency, knowledge gaps, and topology complexity.

## Arguments

Mode: $ARGUMENTS

## Survey (read-only ranking)

```
attention_survey(include_idle: false)
```

Returns ranked `attention_items` sorted by score (0.0–1.0). Each item includes:
- `goal_id`, `attention_score`, `dispatch_mode` (act/learn/escalate/idle)
- `coverage_score`, `max_kappa`, `routing`, `rationale`

Use `include_idle: true` to also see goals that don't need attention right now.

## Run a Full Cycle (survey → triage → dispatch)

```
attention_run_cycle(autonomy_override: "advise")
```

**Autonomy levels:**
- `observe` — survey and rank only, no actions
- `advise` — rank + suggest next steps, no execution
- `act` — rank + execute high-priority items autonomously

Returns: surveyed/actionable/dispatched counts, advice strings, cycle timing.

## Dispatch Modes

- **act** → coverage adequate, topology clean, execute
- **learn** → gaps or low confidence, gather info first
- **escalate** → critically low coverage, need help
- **idle** → doesn't need attention now

## Attention Score Factors

Score combines: urgency, knowledge gap (1.0 - coverage), topology complexity, staleness.

## Session Startup Pattern

1. `attention_survey(include_idle: false)`
2. Pick top-ranked item (highest attention_score)
3. Resume that goal or follow user's request
