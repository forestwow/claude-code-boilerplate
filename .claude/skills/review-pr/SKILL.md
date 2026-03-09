---
description: "Review a GitHub PR thoroughly"
context: fork
agent: pr-reviewer
---

Review PR #$ARGUMENTS.

Use `gh pr view $ARGUMENTS` and `gh pr diff $ARGUMENTS` to get PR details and changes.

Review every changed file for bugs, security issues, performance, test coverage, and code quality. Post review comments.
