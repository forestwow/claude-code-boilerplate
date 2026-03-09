---
name: commit
description: "Create a conventional commit from staged changes"
disable-model-invocation: true
argument-hint: "[optional message guidance]"
---

Create a conventional commit from the current changes.

Steps:

1. Run `git status` and `git diff --cached` to see staged changes
2. If nothing is staged, run `git diff` to see unstaged changes and ask the user what to stage
3. Analyze the changes to determine the commit type and scope
4. If $ARGUMENTS is provided, use it as guidance for the commit message
5. Write a conventional commit message: `type(scope): concise description`
6. Include a body explaining "why" the change was made when non-obvious
7. Run the commit
8. Show the resulting commit hash and message

Follow the project's git-workflow rules in `.claude/rules/git-workflow.md`.
