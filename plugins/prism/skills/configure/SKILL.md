---
name: configure
description: Use when the user wants to register memory systems, update CL dimension weights, view PRISM configuration, or create task profiles. Triggers on "register system", "set weights", "PRISM config", "create profile". Routes through the `config` machine.
argument-hint: <action> [options]
---

# Configure — PRISM Administration

Admin machine for setup and configuration (outside the evaluation loop).

## Arguments

Action to perform: $ARGUMENTS

## Actions

### Register a memory system for evaluation
```
config(action: "register_system", name: "graphonomous", display_name: "Graphonomous v0.4", mcp_endpoint: "stdio", transport: "stdio")
```

### List registered systems
```
config(action: "list_systems")
```

### View full PRISM configuration
```
config(action: "get_config")
```
Returns: current cycle, status, phase, weights, domains, machine count, storage backend.

### Update CL dimension weights
```
config(action: "set_weights", weights: "{\"stability\": 0.20, \"plasticity\": 0.18, \"knowledge_update\": 0.15, \"temporal\": 0.12, \"consolidation\": 0.10, \"epistemic_awareness\": 0.08, \"transfer\": 0.07, \"forgetting\": 0.05, \"feedback\": 0.05}")
```
Weights must sum to 1.0. Requires governance approval during active cycles.

### Create a custom task profile
```
config(action: "create_profile", name: "code_review_agent", dimension_priorities: "{\"stability\": 0.3, \"knowledge_update\": 0.25}", domains: "[\"code\"]")
```
