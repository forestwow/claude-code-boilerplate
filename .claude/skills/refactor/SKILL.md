---
name: refactor
description: "Refactor code without changing behavior"
argument-hint: "[file-path or module]"
context: fork
agent: refactorer
---

Refactor the code at $ARGUMENTS.
If no path is provided, identify the top refactoring opportunities across the codebase based on code smells and complexity.

Understand current behavior, identify improvements, refactor while preserving behavior, run tests to verify.
