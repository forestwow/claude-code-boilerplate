---
name: test
description: "Generate and run tests"
argument-hint: "[file-path or module]"
context: fork
agent: test-writer
---

Write tests for $ARGUMENTS.
If no path is provided, identify untested or under-tested code and prioritize writing tests for the most critical paths.

Analyze the code, identify test cases, write tests following AAA pattern, run them, fix any failures.
