---
name: workflows
description: Use when the user asks "how do I use graphonomous for X?", wants end-to-end recipes, or needs guidance on common multi-step patterns like cold start, codebase exploration, debugging, or autonomous iteration.
argument-hint: [cold-start|warm-resume|explore|debug|ralph-loop|end-session]
---

# Graphonomous Workflows

End-to-end recipes for common tasks. Pick the workflow that matches your situation.

## Arguments

Workflow type: $ARGUMENTS

## Cold Start (empty graph)
1. `retrieve_context(query: "project overview")` — confirm empty
2. `manage_goal(operation: "create_goal", payload: {"title": "Orient on project", ...})`
3. Explore code/docs → `store_node` for each key finding
4. Link nodes with `store_edge`
5. `manage_goal(operation: "set_progress", ...)`

## Warm Resume (existing knowledge)
1. `manage_goal(operation: "list_goals", filters: {"status": "active"})`
2. `attention_survey(include_idle: false)`
3. Pick top attention item or follow user request
4. `retrieve_context(query: "<current topic>")`
5. Continue working with context

## Answer a Question
1. `retrieve_context(query: "<the question>")`
2. If `routing: "deliberate"` → `deliberate(query: "...")`
3. Answer using retrieved knowledge
4. `store_node` for the synthesis
5. If user confirms → `learn_from_outcome(status: "success", ...)`

## Explore a Codebase
1. Create parent goal + sub-goals per module
2. For each module: explore → `store_node` per finding → `store_edge` for relationships
3. `manage_goal(operation: "set_progress", ...)` after each module
4. `review_goal` when all sub-goals done

## Debug a Problem
1. `retrieve_context(query: "prior context on <issue>")`
2. Isolate the issue
3. Test fix
4. `store_node(node_type: "episodic", content: "<what happened>", ...)`
5. `learn_from_outcome(...)` with real causal IDs
6. Link to goal if applicable

## Ralph Loop (autonomous iteration)
1. `attention_survey` → pick top item
2. `retrieve_context` for that goal
3. Act on it
4. `learn_from_outcome`
5. `review_goal` → follow act/learn/escalate
6. Advance to next attention item
7. Repeat; consolidate every 4–5 cycles

## End of Session
1. Store pending knowledge
2. Report outcomes via `learn_from_outcome`
3. Update goal progress/status
4. `run_consolidation(action: "run_and_status", wait_ms: 2000)`
