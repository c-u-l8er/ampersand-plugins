---
name: interact
description: Use when the user wants to run benchmarks, execute scenarios against memory systems, check run status, or view transcripts. Triggers on "run benchmark", "test system", "execute scenario", "check status", "view transcript". Routes through the `interact` machine.
argument-hint: <action> [options]
---

# Interact — "Run the test"

Phase 2 of the PRISM evaluation loop. Execute scenarios against memory systems.

## Arguments

Action to perform: $ARGUMENTS

## Actions

### Run a single scenario against one system
```
interact(action: "run", scenario_id: "<uuid>", system_id: "<uuid>", llm_backend: "claude-sonnet-4-20250514")
```

### Run a scenario sequence (closed-loop, no memory reset)
```
interact(action: "run_sequence", sequence_id: "<uuid>", system_id: "<uuid>", llm_backend: "claude-sonnet-4-20250514")
```

### Run full evaluation matrix
```
interact(action: "run_matrix", suite_id: "<uuid>", systems: "[\"sys1\", \"sys2\"]", models: "[\"claude-sonnet-4-20250514\", \"gpt-4o\"]")
```

### Check run status
```
interact(action: "status", run_id: "<uuid>")
```

### View full interaction transcript
```
interact(action: "transcript", transcript_id: "<uuid>")
```

### Cancel an in-progress run
```
interact(action: "cancel", run_id: "<uuid>")
```
