---
name: compose
description: Use when the user wants to create test scenarios, validate scenario coverage, list/search scenarios, or register repo anchors. Triggers on "create scenarios", "build test suite", "validate coverage", "list scenarios". Routes through the `compose` machine.
argument-hint: <action> [options]
---

# Compose — "What should I test?"

Phase 1 of the PRISM evaluation loop. Build, validate, and manage test scenarios.

## Arguments

Action to perform: $ARGUMENTS

## Actions

### Store agent-composed scenarios
```
compose(action: "scenarios", scenario_ids: "<JSON array of scenario objects>")
```
The agent composes scenarios externally and passes them as structured JSON. Each scenario needs: kind, domain, difficulty, persona, sessions (with turns and cl_challenges), cl_challenges (with dimensions).

PRISM is a pure data layer — no LLM calls happen inside PRISM. The calling agent does all composition.

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

### BYOR (Bring Your Own Repo)
```
compose(action: "byor_register", repo_url: "/path/to/local/repo", domain: "code", commit_range: "HEAD~20..HEAD")
compose(action: "byor_discover", repo_anchor_id: "<uuid>")
```

**NOTE**: `import` and `byor_generate` are NOT implemented. Use `scenarios` to store agent-composed scenarios.
