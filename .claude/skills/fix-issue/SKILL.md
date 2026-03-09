---
description: "End-to-end issue resolution"
---

Resolve the issue specified by $ARGUMENTS.
If no issue number is provided, run `gh issue list --limit 10` and ask the user which one to resolve.

Steps:

1. Fetch the issue details with `gh issue view $ARGUMENTS`
2. Delegate to the **researcher** subagent to understand the relevant codebase context
3. Plan the fix (delegate to **planner** if the fix touches 3+ files)
4. Implement the fix
5. Delegate to the **test-writer** subagent to add or update tests
6. Run the test suite and fix any failures
7. Delegate to the **quality-gate** subagent for final verification
8. Create a conventional commit referencing the issue number

Keep the user informed of progress at each step.
