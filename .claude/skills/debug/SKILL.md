---
description: "Debug an issue systematically"
context: fork
agent: debugger
---

Debug the following issue: $ARGUMENTS.
If no description is provided, check for recent test failures, error logs, or open issues to find something to debug.

Reproduce the issue, gather evidence, identify root cause, implement fix, verify the fix works.

Debugging strategy:
1. Check recent git history for related changes (`git log --oneline -20`)
2. Run failing tests to reproduce
3. Add targeted logging to narrow the scope
4. Form hypothesis, verify with evidence, fix
5. Remove debug logging, run full test suite to confirm fix and no regressions
