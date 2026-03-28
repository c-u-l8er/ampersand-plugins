---
name: goals
description: Use when the user wants to "create a goal", "track progress", "list goals", "update goal", or for any multi-step work spanning multiple turns. Durable intent tracking that survives restarts.
argument-hint: [create|list|update|transition|progress|link] [details]
---

# Goal Management

Track durable intent across sessions — create goals, update progress, link knowledge.

## Arguments

Operation and details: $ARGUMENTS

## Operations

### Create a goal
```
manage_goal(operation: "create_goal", payload: {
  "title": "Implement auth middleware",
  "description": "Add JWT-based auth to all API routes",
  "priority": "high",
  "horizon": "short",
  "completion_criteria": ["All routes require valid JWT", "Tests pass"]
})
```
Save the returned `goal_id`.

### List goals
```
manage_goal(operation: "list_goals", filters: {"status": "active"})
```
Filter by: `proposed`, `active`, `blocked`, `completed`, `failed`, `suspended`, `abandoned`

### Transition goal status
```
manage_goal(operation: "transition_goal", goal_id: "<id>", new_status: "completed", metadata: {
  "reason": "All completion criteria met",
  "evidence": ["test-suite-passed", "coverage-review-act"]
})
```
Always use `transition_goal` (not `update_goal`) for status changes — provides audit trail.

### Set progress
```
manage_goal(operation: "set_progress", goal_id: "<id>", progress: 0.6, metadata: {
  "basis": "3 of 5 sub-goals completed"
})
```
Base on evidence, not optimism.

### Link knowledge to goals
```
manage_goal(operation: "link_nodes", goal_id: "<id>", node_ids: ["<node1>", "<node2>"])
```
Every node created for a goal should be linked. Used by `review_goal` to assess coverage.

## Goal lifecycle
`proposed` → `active` → (`completed` | `failed` | `suspended` | `abandoned`)

## Tips
- Decompose large goals into 3–6 focused sub-goals with `parent_goal_id`
- Check goals at session start with `list_goals`
- Link nodes as you create them
