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

### Judge all 9 dimensions for one transcript (L2)
```
observe(action: "judge_transcript", transcript_id: "<uuid>", judge_model: "gpt-4o")
```

### Judge one specific dimension (debug/manual)
```
observe(action: "judge_dimension", transcript_id: "<uuid>", dimension: "stability", judge_model: "gpt-4o")
```

### Meta-judge one L2 judgment (L3)
```
observe(action: "meta_judge", judgment_id: "<uuid>", meta_judge_model: "claude-sonnet-4-20250514")
```
Meta-judge model MUST be from a different model family than the L2 judge.

### Meta-judge all L2 judgments for a run (L3 batch)
```
observe(action: "meta_judge_batch", run_id: "<uuid>", meta_judge_model: "claude-sonnet-4-20250514")
```

### Human override with audit trail
```
observe(action: "override", judgment_id: "<uuid>", new_score: 0.75, reason: "Judge missed evidence of temporal reasoning in turns 3-5")
```

## The 9 CL Dimensions

Each transcript is scored on all 9:
1. Stability (anti-forgetting) — weight 0.20
2. Plasticity (new acquisition) — weight 0.18
3. Knowledge Update (contradiction) — weight 0.15
4. Temporal Reasoning — weight 0.12
5. Consolidation (abstraction) — weight 0.10
6. Epistemic Awareness — weight 0.08
7. Cross-Domain Transfer — weight 0.07
8. Intentional Forgetting — weight 0.05
9. Outcome Feedback — weight 0.05
