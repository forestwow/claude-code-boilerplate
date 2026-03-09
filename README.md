# Claude Code Boilerplate (ACE)

Production-quality Claude Code configurations for any project.

Drop this into your repo and get a fully-configured Claude Code environment with specialized agents, reusable skills, safety hooks, and coding rules — ready to go in under a minute.

## Quick Start

1. Copy `.claude/` and `CLAUDE.md` to the root of your project.
2. Run `/setup-project` in Claude Code.
3. The setup skill auto-detects your stack, fills in CLAUDE.md placeholders, and configures hooks.

That's it. Claude Code now has project-aware agents, skills, and guardrails.

## What's Included

| Component | Count | Location |
|-----------|-------|----------|
| Agents | 13 | `.claude/agents/` |
| Skills | 15 | `.claude/skills/` |
| Hooks | 3 | `.claude/hooks/` |
| Rules | 5 | `.claude/rules/` |

## Agents

Specialized sub-agents that Claude Code delegates to for focused tasks. Each has a defined role, model preference, and tool access.

| Agent | Purpose |
|-------|---------|
| `code-reviewer` | Code quality review with severity-rated findings |
| `debugger` | Systematic root cause analysis and fix verification |
| `devops-engineer` | CI/CD pipelines and infrastructure configuration |
| `doc-writer` | Documentation generation from source code |
| `migration-worker` | Large-scale code migrations in isolated worktrees |
| `performance-analyzer` | Bottleneck identification and optimization |
| `planner` | Implementation planning (read-only, never edits) |
| `pr-reviewer` | GitHub PR review with inline comments |
| `quality-gate` | Final verification checklist before task completion |
| `refactorer` | Behavior-preserving code restructuring |
| `researcher` | Deep codebase exploration (read-only) |
| `security-auditor` | OWASP/CWE-based vulnerability auditing |
| `test-writer` | Test generation following AAA pattern |

Full catalog: [docs/AGENTS.md](docs/AGENTS.md)

## Skills

Slash commands that trigger multi-step workflows. Run them in Claude Code with `/<skill-name>`.

| Skill | What it does |
|-------|-------------|
| `/setup-project` | Detect stack, fill CLAUDE.md placeholders, configure hooks |
| `/commit` | Create conventional commit from staged changes |
| `/fix-issue <#>` | End-to-end GitHub issue resolution |
| `/review-pr <#>` | Thorough PR review via GitHub CLI |
| `/test <target>` | Generate and run tests |
| `/doc <target>` | Generate documentation |
| `/debug <issue>` | Systematic debugging workflow |
| `/refactor <target>` | Behavior-preserving refactoring |
| `/plan <feature>` | Research and create implementation plan |
| `/research <topic>` | Deep codebase exploration |
| `/deploy <env>` | Deployment workflow |
| `/changelog` | Generate changelog from git history |
| `/security-audit <target>` | Security vulnerability audit |
| `/perf-check <target>` | Performance analysis |
| `/dependency-check` | Check for outdated/vulnerable dependencies |

Full catalog: [docs/SKILLS.md](docs/SKILLS.md)

## Hooks

Shell scripts that run automatically during Claude Code operations:

- **format-after-edit.sh** — Auto-formats files after Edit/Write operations using the project's formatter.
- **protect-files.sh** — Blocks edits to sensitive files (lock files, generated code, etc.).
- **validate-commit.sh** — Runs linter before allowing `git commit`.

Hooks are configured in `.claude/settings.json` under the `hooks` key.

## Rules

Coding standards loaded automatically by Claude Code from `.claude/rules/`:

- **code-quality.md** — Naming, structure, single responsibility, no dead code.
- **error-handling.md** — Explicit error handling, structured errors, resource safety.
- **git-workflow.md** — Conventional commits, atomic commits, branch naming.
- **security.md** — No hardcoded secrets, input validation, least privilege.
- **testing.md** — AAA pattern, behavior over implementation, deterministic tests.

## Configuration

- **`.claude/settings.json`** — Shared settings (permissions, hooks, environment). Commit this.
- **`.claude/settings.local.json`** — Personal overrides (model, API key, extra permissions). Do not commit.
- **`.claude/settings.local.json.example`** — Template for local settings.

## Customization

See [docs/CUSTOMIZATION.md](docs/CUSTOMIZATION.md) for:

- Adapting for different languages and frameworks
- Adding project-specific agents and skills
- Modifying hooks for your toolchain
- Adjusting rules for your team

## Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code)
- [GitHub CLI (`gh`)](https://cli.github.com/) — required for `/review-pr`, `/fix-issue`, and PR-related skills

## License

MIT
