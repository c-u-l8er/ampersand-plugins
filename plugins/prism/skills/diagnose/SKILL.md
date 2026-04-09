---
name: diagnose
description: Use when the user wants diagnostic reports, failure analysis, leaderboards, system comparisons, regression alerts, fix suggestions, or task-fit recommendations. Triggers on "diagnose", "leaderboard", "compare systems", "failure patterns", "suggest fixes", "regressions", "which system is best for". Routes through the `diagnose` machine.
argument-hint: <action> [options]
---

# Diagnose — "What's actionable?"

Phase 5 of the PRISM evaluation loop. This is what makes PRISM a diagnostic tool rather than just a score generator.

## Arguments

Action to perform: $ARGUMENTS

## Diagnostic Actions

### Full diagnostic report
```
diagnose(action: "report", system_id: "<uuid>", cycle: 1)
```

### Clustered failure pattern analysis
```
diagnose(action: "failure_patterns", system_id: "<uuid>", dimension: "stability")
```

### Re-run scenarios after a fix
```
diagnose(action: "retest", system_id: "<uuid>", scenario_ids: "[\"uuid1\"]", version: "v0.4.1")
```

### Before/after verification report
```
diagnose(action: "verify", retest_run_id: "<uuid>")
```

### Cross-cycle regression alerts
```
diagnose(action: "regressions", system_id: "<uuid>", from_cycle: 1, to_cycle: 3)
```

### AI-generated fix suggestions
```
diagnose(action: "suggest_fixes", system_id: "<uuid>", dimension: "stability")
```

## Leaderboard Actions

### Current rankings
```
diagnose(action: "leaderboard", cycle: 1, domain: "code", limit: 20)
```

### Scores over time
```
diagnose(action: "leaderboard_history", system: "graphonomous", from_cycle: 1, to_cycle: 5)
```

### Head-to-head comparison
```
diagnose(action: "compare_systems", system_a: "graphonomous", system_b: "mem0", cycle: 1)
```

### Top system per dimension
```
diagnose(action: "dimension_leaders", cycle: 1, domain: "code")
```

## Task-Fit Actions

### System recommendation for a task profile
```
diagnose(action: "fit_recommendation", profile_id: "<uuid>", budget: "low")
```

### Compare two systems for a specific task
```
diagnose(action: "compare_fit", system_a: "graphonomous", system_b: "mem0", profile_id: "<uuid>")
```

### List available task profiles
```
diagnose(action: "task_profiles")
```
