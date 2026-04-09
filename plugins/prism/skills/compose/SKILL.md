---
name: compose
description: Use when the user wants to create test scenarios, validate scenario coverage, list/search scenarios, or import from external benchmarks. Triggers on "create scenarios", "build test suite", "validate coverage", "list scenarios", "import from BEAM". Routes through the `compose` machine.
argument-hint: <action> [options]
---

# Compose — "What should I test?"

Phase 1 of the PRISM evaluation loop. Build, validate, and manage test scenarios.

## Arguments

Action to perform: $ARGUMENTS

## Actions

### Generate scenarios from a repo anchor
```
compose(action: "scenarios", repo_anchor_id: "<uuid>", count: 10, focus_dimensions: "[\"stability\", \"plasticity\"]")
```

### Validate CL coverage of scenarios
```
compose(action: "validate", scenario_ids: "[\"uuid1\", \"uuid2\"]")
```

### List scenarios with filters
```
compose(action: "list", kind: "anchor", domain: "code", dimension: "stability", difficulty: 3)
```
All filters are optional. Domains: code, medical, business, personal, research, creative, legal, operations.

### Get full scenario details
```
compose(action: "get", scenario_id: "<uuid>")
```

### Retire a scenario
```
compose(action: "retire", scenario_id: "<uuid>", reason: "saturated")
```
Reasons: saturated, ambiguous, too_hard, duplicate. Anchor scenarios cannot be retired.

### Import from external benchmarks
```
compose(action: "import", source: "BEAM", file_path: "/path/to/data.json", domain: "code")
```

### BYOR (Bring Your Own Repo)
```
compose(action: "byor_register", repo_url: "https://github.com/user/repo", domain: "code")
compose(action: "byor_discover", repo_anchor_id: "<uuid>")
compose(action: "byor_generate", repo_anchor_id: "<uuid>", count: 10)
```
