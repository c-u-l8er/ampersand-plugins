---
name: bootstrap
description: Use when starting a benchmarking session, or when the user says "start PRISM", "benchmark", "evaluate memory systems", "initialize PRISM". Sets up the PRISM evaluation engine and checks registered systems.
---

# PRISM Bootstrap

Initialize the PRISM evaluation engine for benchmarking.

## Steps

1. **Check configuration** to verify PRISM is ready:
   ```
   config(action: "get_config")
   ```

2. **List registered systems** to see what can be evaluated:
   ```
   config(action: "list_systems")
   ```

3. **If no systems registered**, register the target system:
   ```
   config(action: "register_system", name: "graphonomous", display_name: "Graphonomous v0.4", mcp_endpoint: "stdio", transport: "stdio")
   ```

4. **Check existing scenarios**:
   ```
   compose(action: "list")
   ```

5. **Report** to the user: what systems are registered, scenario count, current cycle number.

## The Evaluation Loop

PRISM runs a 4-phase closed loop. Each phase maps to a machine:

| Machine | Phase | What it does |
|---------|-------|-------------|
| `compose` | "What should I test?" | Build/manage scenarios from git repos |
| `interact` | "Run the test" | Execute scenarios against memory systems |
| `observe` | "Judge the result" | 3-layer judging across 9 CL dimensions |
| `reflect` | "What should change?" | Gap analysis, IRT recalibration, scenario evolution |
| `diagnose` | "What's actionable?" | Diagnostics, leaderboards, fix verification |
| `config` | Admin | System registration, weights, profiles |

## The 9 CL Dimensions

1. **Stability** (0.20) — Anti-forgetting
2. **Plasticity** (0.18) — New acquisition
3. **Knowledge Update** (0.15) — Contradiction handling
4. **Temporal** (0.12) — Time-aware reasoning
5. **Consolidation** (0.10) — Abstraction/merging
6. **Epistemic Awareness** (0.08) — Uncertainty calibration
7. **Transfer** (0.07) — Cross-domain generalization
8. **Forgetting** (0.05) — Intentional forgetting
9. **Feedback** (0.05) — Outcome-driven learning

## Dual-Loop Architecture

When PRISM benchmarks Graphonomous, both loops interlock:

```
PRISM: compose → interact → observe → reflect → diagnose
                    │
                    ▼
Graphonomous: retrieve → route → act → learn → consolidate
```

11 total tools (down from 76). Selection accuracy ~95%.
