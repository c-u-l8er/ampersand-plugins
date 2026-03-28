---
name: inspect-spec
description: Use when the user wants to explore or understand an [&] Protocol spec — its nodes, edges, capabilities, or structure. Triggers on "inspect spec", "show protocol graph", "what does this spec do".
argument-hint: <path-to-ampersand-json>
allowed-tools: [Read, Glob, Grep]
---

# Inspect [&] Protocol Spec

Explore the structure and semantics of an `.ampersand.json` specification.

## Arguments

File to inspect: $ARGUMENTS

## Steps

1. Read the spec file
2. Parse and summarize:
   - **Nodes**: list all declared nodes with types and descriptions
   - **Edges**: list relationships between nodes (causal, supports, etc.)
   - **Capabilities**: what the spec enables
   - **Metadata**: version, author, protocol version
3. Visualize the graph structure as a text diagram if helpful
4. Cross-reference with the protocol prompt at:
   ```
   /home/travis/ProjectAmp2/AmpersandBoxDesign/prompts/PROTOCOL_PROMPT.md
   ```
