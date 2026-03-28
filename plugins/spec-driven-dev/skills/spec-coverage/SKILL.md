---
name: spec-coverage
description: Use when the user asks "how much of the spec is implemented?", "what's missing?", "spec coverage", or wants to audit implementation against spec. Compares code to spec requirements.
argument-hint: [project-name]
allowed-tools: [Read, Glob, Grep, Bash]
---

# Spec Coverage Audit

Compare implementation against the authoritative spec to find gaps.

## Arguments

Project name: $ARGUMENTS

## Steps

1. Load the project spec (use `/spec-driven-dev:read-spec` locations)
2. Extract discrete requirements/features from the spec
3. Search the codebase for implementations of each requirement
4. Produce a coverage report:
   - Implemented (with file references)
   - Partially implemented (with notes on what's missing)
   - Not yet implemented
   - Implemented but divergent from spec
5. Calculate coverage percentage
6. If Graphonomous is available, store the coverage assessment and link to the project goal
