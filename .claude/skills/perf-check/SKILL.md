---
name: perf-check
description: "Performance analysis and optimization suggestions"
argument-hint: "[file-path or module]"
context: fork
agent: performance-analyzer
---

Analyze performance of $ARGUMENTS. Check algorithmic complexity, N+1 queries, unnecessary allocations, missing caching, blocking operations. Report findings with impact assessment and optimization suggestions.
If no path is provided, analyze the most critical code paths — entry points, hot loops, database queries, and API handlers.
