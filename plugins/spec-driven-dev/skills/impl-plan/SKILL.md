---
name: impl-plan
description: Use when the user wants to plan implementation of a spec feature, asks "how should I build this?", "plan the implementation", or wants a spec-to-code roadmap.
argument-hint: <feature-or-spec-section>
allowed-tools: [Read, Glob, Grep]
---

# Implementation Plan from Spec

Generate an implementation plan grounded in the project spec.

## Arguments

Feature or spec section: $ARGUMENTS

## Steps

1. Read the relevant spec section
2. Read existing code to understand current architecture
3. Identify:
   - What already exists that this builds on
   - What new modules/files are needed
   - What existing code needs modification
   - Dependencies and ordering constraints
4. Produce a plan with:
   - **Goal**: what we're building and why (from spec)
   - **Prerequisites**: what must exist first
   - **Steps**: ordered implementation steps with file paths
   - **Tests**: what to test and how
   - **Spec compliance**: which spec requirements each step addresses
5. If Graphonomous is available, create a goal with sub-goals for each step
