---
name: belief
description: Use when knowledge changes, contradictions are detected, facts become outdated, or corrections are needed. Triggers on "revise belief", "correct knowledge", "contradictions", "knowledge is wrong", "update fact", "expand belief", "contract belief", or when learn_from_outcome reveals failures.
argument-hint: [expand|revise|contract] <content or node_id>
---

# Belief Revision

AGM-style belief management — expand, revise, or contract beliefs with automatic contradiction detection and confidence propagation.

## Tools

- `belief_revise` — expand (add new), revise (replace old), contract (withdraw)
- `belief_contradictions` — detect contradictions for a node or content string

## Operations

### Expand — Add a New Belief
```
belief_revise(operation: "expand", content: "New fact here", confidence: 0.8)
```
Automatically checks for contradictions. Creates bidirectional `:contradicts` edges if found (forming κ=1 SCCs).

### Revise — Replace a Wrong Belief
```
belief_revise(operation: "revise", node_id: "<old_node>", content: "Corrected fact", rationale: "why")
```
Creates new node, supersedes old (confidence → 30%), propagates 0.6× decay through dependents.

### Contract — Withdraw Without Replacement
```
belief_revise(operation: "contract", node_id: "<wrong_node>", rationale: "why")
```
Sets confidence to 0.05, propagates decay. Node preserved for provenance.

## Workflow

1. `belief_contradictions(content: "<new info>")` — check first
2. Assess: is the contradiction real?
3. `belief_revise(operation: "revise/contract/expand")` — act
4. `topology_analyze()` — check for new cycles
5. `deliberate()` — if κ > 0 on affected region
6. `learn_from_outcome()` — report the revision result

## Key Rules

- Always check contradictions before revising
- Use `revise` when old is wrong (not `expand` — that creates contradictions)
- Use `contract` when wrong but no replacement available
- Review affected_node_ids after revision to assess cascade impact
