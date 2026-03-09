# {{PROJECT_NAME}}

> Run `/setup-project` to replace all `{{placeholders}}` with your project-specific values.

## Overview

{{DESCRIPTION}}

**Tech stack:** {{TECH_STACK}}

## Key Commands

| Action | Command |
|--------|---------|
| Build  | `{{BUILD_CMD}}` |
| Test   | `{{TEST_CMD}}` |
| Lint   | `{{LINT_CMD}}` |
| Format | `{{FORMAT_CMD}}` |

## Architecture

{{ARCHITECTURE_NOTES}}

---

## Workflow Rules

You are not a single-pass assistant. You are an orchestrator. Follow these principles on every task.

1. **Delegate to subagents for complex tasks.** If a task involves deep analysis, multi-file changes, or specialized knowledge, spawn the appropriate agent from `.claude/agents/`. Do not attempt everything inline.
2. **Research before you implement.** For any multi-step or ambiguous task, start by delegating to the **researcher agent** to gather context, explore the codebase, and surface constraints. Only then plan and implement. After implementation, delegate to the **quality-gate agent** for verification.
3. **Never leave work half-done.** Complete every task fully — all files saved, all tests passing, all linting clean. If something blocks completion, state exactly what is blocking and what remains. Do not silently skip steps.
4. **Plan non-trivial work.** For tasks touching 3+ files or involving architectural decisions, use `/plan` or the **planner agent** before writing code. A plan prevents wasted effort and misaligned changes.

## Extension Layers

This boilerplate has four extension layers. Know when to use each:

- **Plugins** — always-on context enhancements from marketplaces, loaded automatically via `settings.json`. They provide baseline domain knowledge. Enabled: `code-review`, `security-guidance`, `commit-commands`, `pr-review-toolkit`, `frontend-design`.
- **Rules** (`.claude/rules/`) — project-specific directives injected into your main context. Always active, lightweight. Define coding standards and conventions.
- **Skills** (`.claude/skills/`) — reusable workflows triggered by slash commands (e.g., `/commit`, `/test`). They run in the main conversation or fork to a subagent.
- **Subagents** (`.claude/agents/`) — isolated subprocesses with focused system prompts. Spawned on demand for deep, scoped work. They have their own tools, model, and context.

**How to choose:**

| Need | Use | Example |
|------|-----|---------|
| Baseline domain knowledge (always on) | Plugin | `code-review` plugin informs inline suggestions |
| Project-specific standards | Rule | `code-quality.md` enforces naming conventions |
| Repeatable workflow | Skill | `/commit` creates a conventional commit |
| Deep focused task (multi-file, report) | Subagent | `code-reviewer` agent for a thorough written review |

**When domains overlap** (e.g., code review has a plugin, a rule, AND a subagent):

1. **Plugin** provides the baseline — you already know code review best practices from it.
2. **Rule** adds project-specific constraints on top (English naming, minimal comments, etc.).
3. **Subagent** is for explicit delegation — when the user asks for a thorough review, or when a skill like `/review-pr` triggers it. The subagent runs in isolation, reads every file, and produces a structured report.

Do not spawn a subagent for something a plugin already handles inline. Subagents are for deep work, not quick guidance.

## Verification Mandate

Every task must end with verification. This is non-negotiable.

- **Run the tests.** Never assume they pass. Execute `{{TEST_CMD}}` and confirm green output.
- **Run the linter.** Execute `{{LINT_CMD}}` and fix any issues before declaring completion.
- **For significant changes** (new features, refactors, security-sensitive work), delegate to the **quality-gate** subagent as a final step.
- **Check your own work.** Re-read the original request. Walk through each requirement. If the request had a checklist, confirm every item.

## Code Standards

Project conventions are defined as structured rules in `.claude/rules/`. Claude loads these automatically. The essentials:

- **English only** — all code, variable names, commit messages, comments, and documentation must be in English. No exceptions.
- **Self-explanatory code over comments.** Write code that reads clearly. Add comments only when the *why* is non-obvious. See `.claude/rules/code-quality.md`.
- **Conventional commits.** Every commit follows the conventional-commits format. See `.claude/rules/git-workflow.md` for the full spec.
- **Error handling is mandatory.** No swallowed errors, no empty catch blocks. See `.claude/rules/error-handling.md`.
- **Security by default.** Validate inputs, sanitize outputs, never commit secrets. See `.claude/rules/security.md`.
- **Tests accompany changes.** New logic requires new tests. See `.claude/rules/testing.md`.

Do not duplicate rule content here — read the rule files for specifics.

## Agent Roster

Specialized agents live in `.claude/agents/`. Delegate to them by name:

| Agent | Purpose |
|-------|---------|
| `researcher` | Explore codebase, gather context, answer questions before implementation |
| `planner` | Break down complex tasks into actionable steps |
| `code-reviewer` | Thorough multi-file code review with written findings |
| `test-writer` | Generate comprehensive test suites for new or existing code |
| `debugger` | Diagnose and fix bugs with systematic root-cause analysis |
| `refactorer` | Restructure code while preserving behavior |
| `security-auditor` | Deep security review and vulnerability identification |
| `performance-analyzer` | Profile and optimize performance bottlenecks |
| `doc-writer` | Generate or update documentation |
| `pr-reviewer` | Review pull requests for quality, correctness, and standards |
| `quality-gate` | Final verification — completeness, tests, lint, standards |
| `devops-engineer` | Infrastructure, CI/CD, deployment configuration |
| `migration-worker` | Large-scale code migrations (API upgrades, pattern replacements) in isolated worktrees |
| `meta-engineer` | Optimize Claude Code configs, agents, prompts, and hooks (opus, LLM/prompt expert) |

## Skills Quick Reference

| Skill | What it does |
|-------|--------------|
| `/fix-issue` | Diagnose and fix a reported issue end-to-end |
| `/commit` | Stage and commit changes with a conventional commit message |
| `/plan` | Create a structured plan for a complex task |
| `/test` | Write or run tests for specified code |
| `/review-pr` | Review a pull request for quality and correctness |
| `/debug` | Systematic debugging of a specific problem |
| `/security-audit` | Run a security-focused review of code or dependencies |
| `/refactor` | Restructure code while preserving behavior |
| `/doc` | Generate or update documentation |
| `/research` | Investigate a topic, codebase area, or external resource |
| `/deploy` | Run deployment workflows |
| `/setup-project` | Replace all `{{placeholders}}` in this boilerplate |
| `/improve-config` | Audit and optimize Claude Code agents, skills, hooks, and prompts |

## Working With This Project

1. Read this file first for orientation.
2. Check `.claude/rules/` before making structural decisions.
3. Use `/setup-project` if placeholders above have not been filled in yet.
4. For every task: **research -> plan -> implement -> verify**. No shortcuts.
