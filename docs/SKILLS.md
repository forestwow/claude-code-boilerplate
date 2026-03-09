# Skill Catalog

Skills are slash commands that trigger multi-step workflows in Claude Code. They live in `.claude/skills/<name>/SKILL.md`.

## Skill Overview

| Command | Description | Context | Agent |
|---------|-------------|---------|-------|
| `/setup-project` | Detect stack, fill CLAUDE.md placeholders, configure hooks | inline | none |
| `/commit` | Create conventional commit from staged changes | inline | none |
| `/fix-issue <#>` | End-to-end GitHub issue resolution | inline | multi-agent |
| `/review-pr <#>` | Thorough GitHub PR review | fork | `pr-reviewer` |
| `/test <target>` | Generate and run tests | fork | `test-writer` |
| `/doc <target>` | Generate documentation | fork | `doc-writer` |
| `/debug <issue>` | Systematic debugging workflow | fork | `debugger` |
| `/refactor <target>` | Behavior-preserving refactoring | fork | `refactorer` |
| `/plan <feature>` | Research and create implementation plan | fork | `planner` |
| `/research <topic>` | Deep codebase exploration | fork | `researcher` |
| `/deploy <env>` | Deployment workflow | fork | `devops-engineer` |
| `/changelog` | Generate changelog from git history | inline | none |
| `/security-audit <target>` | Security vulnerability audit | fork | `security-auditor` |
| `/perf-check <target>` | Performance analysis | fork | `performance-analyzer` |
| `/dependency-check` | Check for outdated/vulnerable dependencies | fork | `security-auditor` |

### Key Columns

- **Context**: `inline` runs in the main conversation. `fork` runs in a sub-agent thread (does not pollute your main context).
- **Agent**: The specialized agent the skill delegates to. `multi-agent` means the skill orchestrates several agents. `none` means it runs directly.

## Usage Examples

```
/setup-project                              # Detect stack, fill CLAUDE.md placeholders
/commit                                     # Conventional commit from staged changes
/commit feat: add user auth                 # Hint the commit type via argument
/fix-issue 42                               # Resolve GitHub issue end-to-end (needs gh)
/review-pr 123                              # Review PR, post comments (needs gh)
/test src/auth/login.ts                     # Generate and run tests for a file
/doc src/api/                               # Generate docs for a directory
/debug "500 error on /api/profile"          # Systematic debugging
/refactor src/utils/parser.ts               # Restructure without changing behavior
/plan "add WebSocket notifications"         # Implementation plan (read-only, uses opus)
/research "how does auth middleware work"    # Codebase exploration (read-only)
/deploy staging                             # Deployment workflow
/changelog v1.2.0..HEAD                     # Changelog from git history
/security-audit src/api/                    # OWASP/CWE vulnerability audit
/perf-check src/database/queries.ts         # Performance analysis
/dependency-check                           # Scan for vulnerable/outdated deps
```

## Creating Custom Skills

Create a directory in `.claude/skills/` with a `SKILL.md` file:

```
.claude/skills/my-skill/SKILL.md
```

Use YAML frontmatter for configuration:

```yaml
---
description: "One-line description shown in skill list"
context: fork       # fork | omit for inline
agent: agent-name   # agent to delegate to | omit for direct execution
---
```

Below the frontmatter, write the skill's instructions. Use `$ARGUMENTS` to reference user input passed after the slash command.

Example:

```yaml
---
description: "Run database migrations"
context: fork
agent: devops-engineer
---

Run database migrations for $ARGUMENTS environment.

Check migration status, run pending migrations, verify schema is correct.
```

The skill is immediately available as `/my-skill` in Claude Code.
