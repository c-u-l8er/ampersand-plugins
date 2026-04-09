---
name: benchmark
description: Use when the user wants to run a full benchmark cycle against Graphonomous or any registered memory system. Triggers on "benchmark graphonomous", "run full evaluation", "start benchmark cycle", "evaluate memory system". Orchestrates compose → interact → observe → reflect → diagnose.
argument-hint: <system_name>
---

# Benchmark — Full Evaluation Cycle

Run a complete PRISM evaluation cycle against a memory system.

## Arguments

System to benchmark: $ARGUMENTS

## Full Cycle Steps

### 1. Check readiness
```
config(action: "get_config")
config(action: "list_systems")
```

### 2. Register system if needed
```
config(action: "register_system", name: "graphonomous", display_name: "Graphonomous v0.4", mcp_endpoint: "stdio", transport: "stdio")
```

### 3. Compose scenarios
```
compose(action: "list")
```
If no scenarios exist, create them from a repo anchor or import from external benchmarks.

### 4. Run interactions
```
interact(action: "run", scenario_id: "<uuid>", system_id: "<uuid>", llm_backend: "claude-sonnet-4-20250514")
```
Run each scenario against the target system.

### 5. Judge transcripts
```
observe(action: "judge_transcript", transcript_id: "<uuid>", judge_model: "gpt-4o")
```
Score all 9 CL dimensions per transcript.

### 6. Meta-judge
```
observe(action: "meta_judge_batch", run_id: "<uuid>", meta_judge_model: "claude-sonnet-4-20250514")
```

### 7. Analyze results
```
diagnose(action: "leaderboard")
diagnose(action: "report", system_id: "<uuid>")
```

### 8. Reflect and evolve
```
reflect(action: "analyze_gaps")
reflect(action: "calibrate_irt")
```

## Dual-Loop Architecture

When benchmarking Graphonomous, PRISM's interact phase drives the Graphonomous memory loop:

```
PRISM: compose → interact → observe → reflect → diagnose
                    │
                    ▼
Graphonomous: retrieve → route → act → learn → consolidate
```

The outer loop (PRISM) improves the benchmark.
The inner loop (Graphonomous) improves the memory.
Each makes the other sharper.
