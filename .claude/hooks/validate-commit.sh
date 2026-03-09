#!/usr/bin/env bash
set -uo pipefail

# Run linter before git commit.
# Receives JSON via stdin from Claude Code hooks.
# Extracts command from tool_input; only activates for "git commit".
# Exit 2 with JSON error if linter fails; exit 0 otherwise.

LINT_TIMEOUT=30

INPUT="$(cat 2>/dev/null)" || true

if [[ -z "$INPUT" ]]; then
  exit 0
fi

# Extract the command string from tool_input
if command -v jq &>/dev/null; then
  COMMAND="$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)" || true
else
  COMMAND="$(echo "$INPUT" | sed -n 's/.*"command"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)" || true
fi

if [[ -z "$COMMAND" ]]; then
  exit 0
fi

# Only activate for git commit commands
if [[ "$COMMAND" != *"git commit"* ]]; then
  exit 0
fi

# Determine the project root — walk up from cwd looking for common markers
find_project_root() {
  local dir="${PWD}"
  while [[ "$dir" != "/" ]]; do
    for marker in package.json pyproject.toml setup.py go.mod Cargo.toml Makefile; do
      if [[ -f "$dir/$marker" ]]; then
        echo "$dir"
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
  echo "$PWD"
}

PROJECT_ROOT="$(find_project_root)"

lint_error() {
  local tool="$1"
  local output="$2"
  # Truncate output to keep JSON reasonable (first 500 chars)
  local truncated="${output:0:500}"
  # Escape for JSON
  truncated="$(echo "$truncated" | sed 's/\\/\\\\/g; s/"/\\"/g; s/\t/\\t/g' | tr '\n' ' ')"
  if command -v jq &>/dev/null; then
    jq -n --arg reason "Linter ($tool) failed. Fix issues before committing: $truncated" '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: $reason
      }
    }'
  else
    printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Linter (%s) failed. Fix issues before committing."}}\n' "$tool"
  fi
  exit 2
}

# --- Node.js ---
if [[ -f "$PROJECT_ROOT/package.json" ]]; then
  if [[ -x "$PROJECT_ROOT/node_modules/.bin/eslint" ]]; then
    LINT_OUTPUT="$(cd "$PROJECT_ROOT" && timeout "$LINT_TIMEOUT" ./node_modules/.bin/eslint . --max-warnings=0 2>&1)" || {
      EXIT_CODE=$?
      if [[ $EXIT_CODE -ne 0 ]]; then
        lint_error "eslint" "$LINT_OUTPUT"
      fi
    }
    exit 0
  fi

  # Check if "lint" script exists in package.json
  HAS_LINT="false"
  if command -v jq &>/dev/null; then
    HAS_LINT="$(jq -r '.scripts.lint // empty' "$PROJECT_ROOT/package.json" 2>/dev/null)" || true
  else
    HAS_LINT="$(sed -n '/"lint"/p' "$PROJECT_ROOT/package.json" | head -1)" || true
  fi

  if [[ -n "$HAS_LINT" ]]; then
    LINT_OUTPUT="$(cd "$PROJECT_ROOT" && timeout "$LINT_TIMEOUT" npm run lint 2>&1)" || {
      EXIT_CODE=$?
      if [[ $EXIT_CODE -ne 0 ]]; then
        lint_error "npm run lint" "$LINT_OUTPUT"
      fi
    }
    exit 0
  fi

  exit 0
fi

# --- Python ---
if [[ -f "$PROJECT_ROOT/pyproject.toml" ]] || [[ -f "$PROJECT_ROOT/setup.py" ]]; then
  if command -v ruff &>/dev/null; then
    LINT_OUTPUT="$(cd "$PROJECT_ROOT" && timeout "$LINT_TIMEOUT" ruff check . 2>&1)" || {
      EXIT_CODE=$?
      if [[ $EXIT_CODE -ne 0 ]]; then
        lint_error "ruff" "$LINT_OUTPUT"
      fi
    }
    exit 0
  elif command -v flake8 &>/dev/null; then
    LINT_OUTPUT="$(cd "$PROJECT_ROOT" && timeout "$LINT_TIMEOUT" flake8 . 2>&1)" || {
      EXIT_CODE=$?
      if [[ $EXIT_CODE -ne 0 ]]; then
        lint_error "flake8" "$LINT_OUTPUT"
      fi
    }
    exit 0
  fi
  exit 0
fi

# --- Go ---
if [[ -f "$PROJECT_ROOT/go.mod" ]]; then
  if command -v go &>/dev/null; then
    LINT_OUTPUT="$(cd "$PROJECT_ROOT" && timeout "$LINT_TIMEOUT" go vet ./... 2>&1)" || {
      EXIT_CODE=$?
      if [[ $EXIT_CODE -ne 0 ]]; then
        lint_error "go vet" "$LINT_OUTPUT"
      fi
    }
    exit 0
  fi
  exit 0
fi

# --- Rust ---
if [[ -f "$PROJECT_ROOT/Cargo.toml" ]]; then
  if command -v cargo &>/dev/null; then
    LINT_OUTPUT="$(cd "$PROJECT_ROOT" && timeout "$LINT_TIMEOUT" cargo clippy 2>&1)" || {
      EXIT_CODE=$?
      if [[ $EXIT_CODE -ne 0 ]]; then
        lint_error "cargo clippy" "$LINT_OUTPUT"
      fi
    }
    exit 0
  fi
  exit 0
fi

# No recognized project type — allow commit
exit 0
