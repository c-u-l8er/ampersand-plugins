---
name: observe
description: Use when the user wants to judge transcripts, evaluate CL dimensions, run meta-judgments, or override scores. Triggers on "judge", "score transcript", "meta-judge", "override judgment". Routes through the `observe` machine.
argument-hint: <action> [options]
---

# Observe — "Judge the result"

Phase 3 of the PRISM evaluation loop. Three-layer judging system.

## Arguments

Action to perform: $ARGUMENTS

## Actions

### Judge all dimensions for one transcript (L2)
```
observe(action: "judge_transcript", transcript_id: "<uuid>", reason: "<JSON array of agent judgments>")
```

The `reason` param accepts a JSON array of agent-provided judgments, each with:
- `dimension` — one of the 9 valid dimension strings (see below)
- `challenge_composite` — 0.0-1.0
- `unprompted_score` — 0.0-1.0
- `composite_score` — 0.0-1.0
- `evidence` — text explaining the score

**IMPORTANT**: The `judge_model` param is optional. The agent IS the judge.

### Judge a single dimension (L2 debug)
```
observe(action: "judge_dimension", transcript_id: "<uuid>", dimension: "stability")
```
Useful for debugging or re-scoring a specific dimension.

### Meta-judge one L2 judgment (L3)
```
observe(action: "meta_judge", judgment_id: "<uuid>", meta_judge_model: "claude-sonnet-4-20250514")
```
L3 meta-judge evaluates the quality of an L2 judgment. The `meta_judge_model` MUST differ from the L2 judge model.

### Meta-judge all L2 judgments for a run (L3 batch)
```
observe(action: "meta_judge_batch", run_id: "<uuid>", meta_judge_model: "claude-sonnet-4-20250514")
```
Batch meta-judging across all L2 judgments in a run.

### Human override with audit trail
```
observe(action: "override", judgment_id: "<uuid>", new_score: 0.85, reason: "L2 missed edge case")
```
Manual score correction with full audit logging.

## The 9 CL Dimensions (valid dimension strings)

Use these exact strings in judgments:
1. `stability` — Anti-forgetting (weight 0.20)
2. `plasticity` — New acquisition (weight 0.18)
3. `knowledge_update` — Contradiction handling (weight 0.15)
4. `temporal` — Temporal reasoning (weight 0.12)
5. `consolidation` — Abstraction (weight 0.10)
6. `epistemic_awareness` — Calibrated confidence, knowing unknowns (weight 0.08)
7. `transfer` — Cross-domain transfer (weight 0.07)
8. `forgetting` — Intentional forgetting (weight 0.05)
9. `feedback` — Outcome feedback (weight 0.05)

**WARNING**: Do NOT use `"uncertainty"` — the valid string is `"epistemic_awareness"`. The CLCategories module internally uses `:uncertainty` as the atom ID but the Judgment model validates against `"epistemic_awareness"`. This naming mismatch is a known bug (see `PRISM/lib/prism/benchmark/cl_categories.ex:241` vs `PRISM/lib/prism/judgment.ex:16-19`).
