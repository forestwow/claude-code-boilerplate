# Customization Guide

How to adapt the Claude Code boilerplate for your project.

## Step 1: Run Setup

Start by running `/setup-project`. It auto-detects your stack and fills in CLAUDE.md placeholders. Everything below covers manual tuning beyond what setup handles.

## Customizing CLAUDE.md

CLAUDE.md is the first file Claude Code reads. It contains placeholders in `{{DOUBLE_BRACES}}`:

| Placeholder | What to fill in |
|-------------|----------------|
| `{{PROJECT_NAME}}` | Your project name |
| `{{DESCRIPTION}}` | One-paragraph project description |
| `{{TECH_STACK}}` | Language, framework, key libraries |
| `{{BUILD_CMD}}` | Build command (e.g., `npm run build`) |
| `{{TEST_CMD}}` | Test command (e.g., `pytest`) |
| `{{LINT_CMD}}` | Lint command (e.g., `eslint .`) |
| `{{FORMAT_CMD}}` | Format command (e.g., `prettier --write .`) |
| `{{ARCHITECTURE_NOTES}}` | Key architectural decisions, directory structure, data flow |

Keep CLAUDE.md concise. Detailed conventions belong in `.claude/rules/`.

## Adapting for Different Languages

### Hook Scripts

The hooks in `.claude/hooks/` need to know your toolchain:

- **format-after-edit.sh** — Detects formatter from config files (`.prettierrc`, `rustfmt.toml`, etc.). Add `elif` branches for your formatter.
- **validate-commit.sh** — Runs linter before `git commit`. Add detection for your linter.
- **protect-files.sh** — Blocks edits to sensitive files. Add new `case` blocks or `if` conditions matching your project's protected file patterns (lock files, credentials, keys).

### Rules

Rules in `.claude/rules/` are language-agnostic by default. To add language-specific conventions:

1. Create a new rule file, e.g., `.claude/rules/python.md` or `.claude/rules/react.md`.
2. Write project-specific standards: import ordering, module structure, error patterns, naming conventions.
3. Claude Code loads all `.md` files in the rules directory automatically.

Keep rules short and prescriptive. See existing files in `.claude/rules/` for the format.

## Adding Project-Specific Agents

Create a `.md` file in `.claude/agents/`:

```yaml
---
model: sonnet
tools: ["Read", "Edit", "Write", "Glob", "Grep", "Bash"]
---

# My Custom Agent

Role definition and instructions here.
```

Guidelines:
- Give the agent a single, clear responsibility.
- Restrict tools to what it needs. Read-only agents should not have Edit/Write/Bash.
- Use `memory: project` if the agent benefits from remembering past interactions.
- Use `isolation: worktree` for agents that make large, risky changes.
- Use `permissionMode: plan` for agents that should only analyze, never modify.

## Adding Project-Specific Skills

Create a directory with a `SKILL.md` file in `.claude/skills/`:

```
.claude/skills/lint-fix/SKILL.md
```

```yaml
---
description: "Auto-fix all lint errors"
---

Run the project linter with auto-fix enabled. Steps:
1. Detect the linter (eslint, ruff, clippy, etc.)
2. Run with --fix flag
3. Report what was fixed
4. Stage the changes
```

To have a skill delegate to a custom agent:

```yaml
---
description: "Run database migrations"
context: fork
agent: db-admin
---
```

This requires a matching `.claude/agents/db-admin.md` file.

## Modifying Hooks

Hooks are configured in `.claude/settings.json` under the `hooks` key. To add a hook:

1. Create a shell script in `.claude/hooks/`.
2. Register it in `settings.json` under `hooks.PreToolUse` (runs before tool execution) or `hooks.Stop` (runs before finishing).
3. Use `matcher` to target specific tools (regex, e.g., `"Edit|Write"`).
4. The script receives JSON on stdin with `tool_input`. Exit 2 to block the operation, exit 0 to allow.

## Adjusting Permissions

- **Shared** (`settings.json`): Permissions for all users. Commit this file.
- **Personal** (`settings.local.json`): Your overrides (model, API key, extra Bash access). Do not commit.
- Copy `settings.local.json.example` to `settings.local.json` to get started.

## Tips

- **Keep CLAUDE.md short.** Move detailed conventions to rules files.
- **Use `context: fork`** on skills that do heavy work. It keeps your main conversation clean.
- **Use `memory: project`** sparingly. It's useful for agents that build up project knowledge (reviewer, auditor) but adds overhead.
- **Test hooks manually.** Run them with sample JSON input before relying on them: `echo '{"tool_input":{"file_path":"test.js"}}' | .claude/hooks/your-hook.sh`
- **Pin agent models.** Use `model: sonnet` for speed-sensitive agents and `model: opus` for reasoning-heavy ones like the planner.
- **Scope tool access.** Give agents only the tools they need. A researcher with Write access is a footgun.
