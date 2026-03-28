---
name: validate
description: Use when the user wants to validate an .ampersand.json file, check protocol compliance, or verify a spec against the [&] Protocol schema. Triggers on "validate spec", "check ampersand", "protocol compliance".
argument-hint: <path-to-ampersand-json>
allowed-tools: [Read, Bash, Glob, Grep]
---

# Validate [&] Protocol Spec

Validate an `.ampersand.json` file against the [&] Protocol schema.

## Arguments

File to validate: $ARGUMENTS

## Steps

1. Read the target file (or find `.ampersand.json` files if no path given):
   ```
   Glob: **/*.ampersand.json
   ```

2. Read the protocol schema for reference:
   ```
   Read: /home/travis/ProjectAmp2/AmpersandBoxDesign/schemas/
   ```

3. If the Elixir reference impl is built, run validation:
   ```bash
   cd /home/travis/ProjectAmp2/AmpersandBoxDesign/reference/elixir/ampersand_core
   ./ampersand validate <path>
   ```

4. Report: valid/invalid, any schema violations, suggestions for fixes.
