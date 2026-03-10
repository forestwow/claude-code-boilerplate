# Agent Catalog

All agents live in `.claude/agents/`. Claude Code delegates to them for focused, scoped tasks.

## Agent Overview

| Agent | Purpose | Model | Memory | Key Tools |
|-------|---------|-------|--------|-----------|
| `code-reviewer` | Code quality review with severity ratings | sonnet | project | Read-only defaults |
| `debugger` | Root cause analysis, fix, and verification | default | project | Read, Edit, Write, Bash |
| `devops-engineer` | CI/CD pipelines, containers, IaC | sonnet | none | Read, Edit, Write, Bash |
| `doc-writer` | Generate documentation from source | sonnet | none | Read, Write, Glob, Grep |
| `migration-worker` | Batch code migrations in worktrees | sonnet | none | Read, Edit, Write, Bash |
| `performance-analyzer` | Bottleneck and optimization analysis | sonnet | project | Read, Glob, Grep, Bash |
| `planner` | Implementation planning (plan mode) | opus | none | Read, Glob, Grep, Bash |
| `pr-reviewer` | GitHub PR review with inline comments | sonnet | none | Read, Glob, Grep, Bash |
| `quality-gate` | Final pass/fail verification checklist | sonnet | none | Read, Glob, Grep, Bash |
| `refactorer` | Behavior-preserving restructuring | sonnet | none | Read, Edit, Write, Bash |
| `researcher` | Deep codebase exploration (read-only) | sonnet | none | Read, Glob, Grep, Bash |
| `security-auditor` | OWASP/CWE vulnerability auditing | sonnet | project | Read, Glob, Grep, Bash |
| `test-writer` | Test generation and execution | sonnet | project | Read, Edit, Write, Bash |
| `meta-engineer` | Claude Code config optimization and prompt engineering | opus | project | Read, Edit, Write, Bash, Glob, Grep, WebFetch |

### Key Columns

- **Model**: Which Claude model the agent prefers. `opus` for complex reasoning, `sonnet` for speed, `default` inherits the session model.
- **Memory**: `project` means the agent retains context across invocations within the project. `none` means stateless.
- **Key Tools**: The tool subset the agent has access to. Read-only agents cannot modify files.

## When to Use Each Agent

### Code Writing & Modification
- **`refactorer`** — Restructure existing code without changing behavior. Use when code works but is messy.
- **`debugger`** — When something is broken. Reproduces the issue, finds root cause, implements and verifies the fix.
- **`migration-worker`** — Large-scale changes (rename across 100 files, upgrade framework). Runs in an isolated worktree for safety.
- **`devops-engineer`** — Create or modify Dockerfiles, GitHub Actions, Terraform, CI configs.

### Code Analysis (Read-Only)
- **`researcher`** — Answer questions about the codebase. Traces data flow, maps dependencies, explains architecture.
- **`planner`** — Produce a step-by-step implementation plan before writing code. Uses opus for deeper reasoning. Runs in plan mode and never edits files.
- **`performance-analyzer`** — Find N+1 queries, unnecessary allocations, missing caching, algorithmic issues.

### Code Review & Quality
- **`code-reviewer`** — Review code for bugs, security, performance, and style. Outputs severity-rated findings.
- **`pr-reviewer`** — Same as code-reviewer but operates on GitHub PRs. Posts comments via `gh` CLI.
- **`quality-gate`** — Final check before marking a task done. Runs a pass/fail checklist to catch missed items.
- **`security-auditor`** — Focused security audit: OWASP Top 10, dependency vulnerabilities, secret exposure.

### Documentation & Testing
- **`doc-writer`** — Generate inline docs (JSDoc, docstrings) or standalone documentation files.
- **`test-writer`** — Write tests following AAA pattern, run them, fix failures, report coverage gaps.

### Configuration & Meta
- **`meta-engineer`** — Audit and optimize Claude Code configs, agents, skills, hooks, and prompts. Uses opus for deep prompt engineering reasoning. Checks latest docs for new features.

## Interaction Patterns

Agents frequently collaborate through skills:

- **`/fix-issue`** chains: `researcher` (understand context) -> fix implementation -> `test-writer` (add tests) -> `quality-gate` (verify).
- **`/review-pr`** delegates to `pr-reviewer`, which applies the same review categories as `code-reviewer`.
- **`/plan`** uses `planner` (opus) for deep analysis, then the plan guides subsequent implementation.
- **`/dependency-check`** and **`/security-audit`** both delegate to `security-auditor`.

## Creating Custom Agents

Create a new `.md` file in `.claude/agents/`. Use YAML frontmatter for configuration:

```yaml
---
model: sonnet          # sonnet | opus | omit for default
memory: project        # project | omit for stateless
isolation: worktree    # worktree | omit for normal
permissionMode: plan   # plan | omit for normal
tools: ["Read", "Glob", "Grep", "Bash"]
---
```

Below the frontmatter, write the agent's system prompt. Include:

1. **Role definition** — Who the agent is and what it does.
2. **Process** — Step-by-step workflow the agent follows.
3. **Constraints** — What the agent must not do.
4. **Output format** — How to structure the response.
5. **Verification** — Self-check before finishing.

Reference existing agents in `.claude/agents/` for examples.
