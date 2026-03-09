---
description: "Create a conventional commit from staged changes"
---

Create a conventional commit.

Steps:

1. Run `git status` and `git diff --cached` to see staged changes
2. If no changes staged, ask user what to stage
3. Analyze changes to determine commit type (use $ARGUMENTS if provided)
4. Write a conventional commit message: type(scope): concise description + body explaining why
5. Run the commit

Follow the project's git-workflow rules.
