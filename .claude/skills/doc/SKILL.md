---
name: doc
description: "Generate documentation"
argument-hint: "[file-path or module]"
context: fork
agent: doc-writer
---

Generate documentation for $ARGUMENTS.
If no target is provided, identify undocumented or poorly documented public APIs and generate documentation for them.

Read the target code, write clear documentation following project conventions.

Before writing:
- Check existing documentation for style, format, and location conventions
- Match the project's doc format (JSDoc, docstrings, Markdown, etc.)
- Include usage examples for every public API
- Place documentation where the project expects it (inline, README, docs/ folder)
