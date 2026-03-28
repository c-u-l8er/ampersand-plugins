---
name: bootstrap
description: Use when starting a new session, switching topics, or when the user says "bootstrap", "start session", "initialize graphonomous", or "load memory". Activates the Graphonomous-first memory loop and orients on prior context.
allowed-tools: [Read, Grep, Glob]
---

# Graphonomous Bootstrap

Initialize the Graphonomous-first memory loop for this session.

## Steps

1. **Retrieve prior context** for the user's current topic:
   ```
   retrieve_context(query: "summary of prior work on <topic>")
   ```

2. **Check active goals** to regain session continuity:
   ```
   manage_goal(operation: "list_goals")
   ```

3. **Survey attention** to see what needs focus:
   ```
   attention_survey(include_idle: false)
   ```

4. **Adopt the policy**: "Graphonomous-first memory loop is active."

5. **Report** to the user: what prior context exists, which goals are active, and what the attention engine recommends focusing on.

## Core Loop (apply for remainder of session)

1. **Retrieve first** — `retrieve_context` before reasoning/acting
2. **Reason and act** — use retrieved context + conversation
3. **Store new knowledge** — `store_node` / `store_edge` for durable learnings
4. **Close the loop** — `learn_from_outcome` when you have outcome signals
5. **Maintain** — `run_consolidation` periodically and at session end

## Session End Checklist

Before ending a productive session:
1. Store key new knowledge discovered
2. Report outcomes via `learn_from_outcome`
3. Update goal progress
4. Trigger `run_consolidation(action: "run_and_status", wait_ms: 2000)`
