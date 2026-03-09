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

## Conventions

Project conventions are defined as structured rules in `.claude/rules/`. Claude loads these automatically. Key areas covered:

- Coding style and patterns
- Error handling expectations
- Naming conventions
- File and directory structure

Refer to individual rule files for specifics. Do not duplicate rule content here.

## Agent Usage

Specialized agents live in `.claude/agents/`. Use them for scoped tasks:

- Agents are invoked via the Agent tool or through skills in `.claude/skills/`
- Each agent file describes its purpose, capabilities, and constraints
- Prefer delegating to an agent when a task fits its specialty

## Working With This Project

- Read this file first for orientation.
- Check `.claude/rules/` before making structural decisions.
- Use `/setup-project` if placeholders above have not been filled in yet.
- The quality-gate agent can verify completeness before finishing a task.
