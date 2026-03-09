#!/usr/bin/env bash
set -uo pipefail

# Block edits to sensitive files.
# Receives JSON via stdin from Claude Code hooks.
# Extracts file_path from tool_input and checks against deny patterns.
# Exit 2 with JSON error to block; exit 0 to allow.

INPUT="$(cat 2>/dev/null)" || true

if [[ -z "$INPUT" ]]; then
  exit 0
fi

if command -v jq &>/dev/null; then
  FILE_PATH="$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)" || true
else
  FILE_PATH="$(echo "$INPUT" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)" || true
fi

if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

BASENAME="$(basename "$FILE_PATH")"
BASENAME_LOWER="$(echo "$BASENAME" | tr '[:upper:]' '[:lower:]')"

block() {
  local reason="$1"
  # Output JSON error object for Claude Code
  printf '{"error":"Blocked edit to %s: %s"}\n' "$BASENAME" "$reason"
  exit 2
}

# --- .env files ---
# Matches .env, .env.local, .env.production, etc.
if [[ "$BASENAME" == ".env" ]] || [[ "$BASENAME" == .env.* ]]; then
  block "environment/secrets file"
fi

# --- Credentials and secrets files ---
if [[ "$BASENAME_LOWER" == *credentials* ]] || [[ "$BASENAME_LOWER" == *secrets* ]]; then
  block "credentials/secrets file"
fi

# --- Lock files ---
case "$BASENAME" in
  package-lock.json|yarn.lock|pnpm-lock.yaml|Gemfile.lock|poetry.lock|Cargo.lock|go.sum)
    block "lock file (auto-generated, do not edit manually)"
    ;;
esac

# --- Private key / certificate files ---
case "$BASENAME_LOWER" in
  *.pem|*.key)
    block "private key or certificate file"
    ;;
esac

# All clear
exit 0
