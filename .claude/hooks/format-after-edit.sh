#!/usr/bin/env bash
set -uo pipefail

# Auto-format files after edits.
# Receives JSON via stdin from Claude Code hooks.
# Extracts file_path from tool_input and runs the appropriate formatter.

# Read stdin safely (avoid breaking under set -e if stdin is empty)
INPUT="$(cat 2>/dev/null)" || true

if [[ -z "$INPUT" ]]; then
  exit 0
fi

# Extract file_path from tool_input using portable JSON parsing
# Try jq first, fall back to simple pattern match
if command -v jq &>/dev/null; then
  FILE_PATH="$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)" || true
else
  # Rough extraction — handles the common {"tool_input":{"file_path":"/some/path",...}} shape
  FILE_PATH="$(echo "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)" || true
fi

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

# File must exist to format
if [[ ! -f "$FILE_PATH" ]]; then
  exit 0
fi

# Determine the project root (directory of the file, walk up to find common markers)
FILE_DIR="$(dirname "$FILE_PATH")"
EXT="${FILE_PATH##*.}"
EXT="$(echo "$EXT" | tr '[:upper:]' '[:lower:]')"

# Helper: find a local binary in node_modules relative to the file
find_local_bin() {
  local dir="$FILE_DIR"
  while [[ "$dir" != "/" ]]; do
    if [[ -x "$dir/node_modules/.bin/$1" ]]; then
      echo "$dir/node_modules/.bin/$1"
      return 0
    fi
    dir="$(dirname "$dir")"
  done
  return 1
}

# Helper: run a formatter with a short timeout
run_fmt() {
  timeout 10 "$@" 2>/dev/null || true
}

case "$EXT" in
  ts|tsx|js|jsx|mjs|cjs)
    PRETTIER="$(find_local_bin prettier 2>/dev/null)" || true
    if [[ -n "$PRETTIER" ]]; then
      run_fmt "$PRETTIER" --write "$FILE_PATH"
    elif command -v prettier &>/dev/null; then
      run_fmt prettier --write "$FILE_PATH"
    elif command -v deno &>/dev/null; then
      run_fmt deno fmt "$FILE_PATH"
    fi
    ;;

  py)
    if command -v ruff &>/dev/null; then
      run_fmt ruff format "$FILE_PATH"
    elif command -v black &>/dev/null; then
      run_fmt black --quiet "$FILE_PATH"
    fi
    ;;

  go)
    if command -v gofmt &>/dev/null; then
      run_fmt gofmt -w "$FILE_PATH"
    fi
    ;;

  rs)
    if command -v rustfmt &>/dev/null; then
      run_fmt rustfmt "$FILE_PATH"
    fi
    ;;

  rb)
    if command -v rubocop &>/dev/null; then
      run_fmt rubocop -A --stderr "$FILE_PATH"
    fi
    ;;

  java|kt)
    # Skip — IDE handles these
    ;;

  css|scss|less|html|json|yaml|yml|md)
    PRETTIER="$(find_local_bin prettier 2>/dev/null)" || true
    if [[ -n "$PRETTIER" ]]; then
      run_fmt "$PRETTIER" --write "$FILE_PATH"
    elif command -v prettier &>/dev/null; then
      run_fmt prettier --write "$FILE_PATH"
    fi
    ;;
esac

# Always succeed — never block an edit
exit 0
