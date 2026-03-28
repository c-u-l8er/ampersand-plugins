---
name: read-spec
description: Use when starting work on any [&] portfolio project, or when the user says "read the spec", "what does the spec say", "check the spec". Loads the authoritative project spec before implementation.
argument-hint: [project-name]
allowed-tools: [Read, Glob, Grep]
---

# Read Project Spec

Load the authoritative spec for a portfolio project before implementation work.

## Arguments

Project name: $ARGUMENTS

## Spec Locations

| Project | Spec Path |
|---------|-----------|
| graphonomous | `graphonomous.com/project_spec/README.md` |
| webhost | `WebHost.Systems/project_spec/spec_v1/00_MASTER_SPEC.md` |
| bendscript | `bendscript.com/project_spec/README.md` |
| agentelic | `agentelic.com/project_spec/README.md` |
| agentromatic | `agentromatic.com/project_spec/README.md` |
| delegatic | `delegatic.com/project_spec/README.md` |
| deliberatic | `deliberatic.com/project_spec/README.md` |
| opensentience | `opensentience.org/project_spec/README.md` |
| specprompt | `specprompt.com/project_spec/README.md` |
| geofleetic | `geofleetic.com/project_spec/README.md` |
| ticktickclock | `ticktickclock.com/project_spec/README.md` |
| fleetprompt | `fleetprompt.com/project_spec/README.md` |
| ampersand | `AmpersandBoxDesign/prompts/PROTOCOL_PROMPT.md` |

## Steps

1. Identify which project the user is working on (from argument or context)
2. Read the spec file
3. Summarize: purpose, architecture, key components, constraints, completion criteria
4. Note any related specs or cross-project dependencies
5. If Graphonomous is available, store a retrieval-ready summary as a semantic node
