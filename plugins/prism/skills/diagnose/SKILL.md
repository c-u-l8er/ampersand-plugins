---
name: diagnose
description: Use when the user wants diagnostic reports, failure analysis, leaderboards, system comparisons, regression alerts, fix suggestions, or task-fit recommendations. Triggers on "diagnose", "leaderboard", "compare systems", "failure patterns", "suggest fixes", "regressions", "which system is best for". Routes through the `diagnose` machine.
argument-hint: <action> [options]
---

# Diagnose — "What's actionable?"

Phase 5 of the PRISM evaluation loop. This is what makes PRISM a diagnostic tool rather than just a score generator.

## Arguments

Action to perform: $ARGUMENTS

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

## Diagnostic Actions

### Full diagnostic report
```
diagnose(action: "report", system_id: "<uuid>", cycle: 1)
```
Comprehensive diagnostic: failures, fixes, regressions in one report.

### Clustered failure analysis
```
diagnose(action: "failure_patterns", system_id: "<uuid>", dimension: "stability")
```
Groups failures by dimension and identifies patterns.

### Re-run scenarios after a fix
```
diagnose(action: "retest", system_id: "<uuid>", scenario_ids: "[\"<uuid>\", ...]", version: "v0.4.1")
```
Re-runs specific scenarios to verify a fix. Tag with version label.

### Before/after comparison
```
diagnose(action: "verify", retest_run_id: "<uuid>")
```
Compares original vs retest scores to confirm improvement.

### Cross-cycle regression analysis
```
diagnose(action: "regressions", system_id: "<uuid>", from_cycle: 1, to_cycle: 5)
```
Detects dimensions or scenarios that regressed between cycles.

### Fix suggestions
```
diagnose(action: "suggest_fixes", system_id: "<uuid>", dimension: "transfer")
```
AI-generated fix suggestions based on failure patterns.

## Task-Fit Actions

### System recommendation for a task profile
```
diagnose(action: "fit_recommendation", profile_id: "<uuid>", budget: "medium")
```
Recommends the best system for a given task profile and budget.

### Compare two systems for a specific task
```
diagnose(action: "compare_fit", system_a: "graphonomous", system_b: "mem0", profile_id: "<uuid>")
```

### List task profiles
```
diagnose(action: "task_profiles")
```
Lists pre-built and custom task profiles with their dimension priorities.
