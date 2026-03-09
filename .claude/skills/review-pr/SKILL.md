---
description: "Review a GitHub PR thoroughly"
context: fork
agent: pr-reviewer
---

Review PR #$ARGUMENTS.
If no PR number is provided, find the most recent open PR with `gh pr list --limit 1` and review it.

Use `gh pr view $ARGUMENTS` and `gh pr diff $ARGUMENTS` to get PR details and changes.

Review every changed file for bugs, security issues, performance, test coverage, and code quality. Post review comments.
