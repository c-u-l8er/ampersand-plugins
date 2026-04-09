---
name: reflect
description: Use when the user wants to analyze evaluation gaps, evolve scenarios, advance evaluation cycles, recalibrate IRT parameters, or get system recommendations. Triggers on "analyze gaps", "evolve scenarios", "next cycle", "calibrate", "cycle history". Routes through the `reflect` machine.
argument-hint: <action> [options]
---

# Reflect — "What should change?"

Phase 4 of the PRISM evaluation loop. Self-improvement through gap analysis, scenario evolution, and IRT recalibration.

## Arguments

Action to perform: $ARGUMENTS

## Actions

### Analyze gaps in current evaluation
```
reflect(action: "analyze_gaps", cycle: 1)
```
Identifies: under-tested dimensions, saturated scenarios, low-variance dims, domain gaps.

### Evolve scenarios based on gap analysis
```
reflect(action: "evolve", cycle: 1, recommendations: "[{\"action\": \"retire\", \"scenario_id\": \"<uuid>\", \"reason\": \"saturated\"}, ...]")
```
Apply gap analysis recommendations: retire, extend, fork, or promote scenarios.

### Advance to next evaluation cycle
```
reflect(action: "advance_cycle")
```
Runs all 4 phases: Compose → Interact → Observe → Reflect.

### Recalibrate IRT parameters
```
reflect(action: "calibrate_irt")
```
Updates difficulty and discrimination parameters from accumulated cycle data.

### View cycle history
```
reflect(action: "cycle_history")
```
Full history of cycles and improvements.

### System recommendation for your use case (BYOR)
```
reflect(action: "byor_recommend", repo_anchor_id: "<uuid>", priorities: "{\"stability\": 0.3, \"transfer\": 0.3}", budget: "low")
```
Recommends a memory system based on your repo's patterns and priorities.

### Infer task profile from repo patterns (BYOR)
```
reflect(action: "byor_infer_profile", repo_anchor_id: "<uuid>")
```
Analyzes your repo's commit history and auto-discovers which CL dimensions matter most.
