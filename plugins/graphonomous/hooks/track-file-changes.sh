#!/bin/bash
set -euo pipefail

# PostToolUse hook: tracks file paths changed by Write/Edit tools
# Appends to a JSONL tracker file that /graphonomous:sync reads
# No jq dependency — uses pure bash string extraction

TRACKER_FILE="/tmp/graphonomous-changed-files.jsonl"
input=$(cat)

# Extract tool_name using grep + sed (handles JSON without jq)
tool_name=$(echo "$input" | grep -o '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"tool_name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

# Only process Write and Edit
case "$tool_name" in
  Write|Edit) ;;
  *) exit 0 ;;
esac

# Extract file_path from tool_input
file_path=$(echo "$input" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')

# Skip if no file path
if [ -z "$file_path" ]; then
  exit 0
fi

# Skip non-source files
case "$file_path" in
  *node_modules/*|*_build/*|*/deps/*|*.beam|*.gz|*.zip|*.png|*.jpg|*.gif|*.ico|*.woff*|*.ttf)
    exit 0
    ;;
esac

# Append to tracker file as JSONL
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
echo "{\"path\":\"$file_path\",\"tool\":\"$tool_name\",\"at\":\"$timestamp\"}" >> "$TRACKER_FILE"

exit 0
