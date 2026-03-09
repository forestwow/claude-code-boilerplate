---
description: "End-to-end issue resolution"
---

Resolve GitHub issue #$ARGUMENTS.

Steps:

1. Fetch issue with `gh issue view $ARGUMENTS`
2. Use researcher agent to understand the codebase context
3. Plan the fix
4. Implement the fix
5. Use test-writer agent to add/update tests
6. Run all tests
7. Use quality-gate agent to verify
8. Create a conventional commit

Keep the user informed of progress.
