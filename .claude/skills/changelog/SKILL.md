---
description: "Generate changelog from git history"
---

Generate a changelog from git history. Steps: 1) Run `git log --oneline` for the range $ARGUMENTS (default: since last tag or last 50 commits), 2) Group commits by type (feat, fix, refactor, etc.), 3) Write a formatted changelog in Keep a Changelog format, 4) Include breaking changes section if any commits contain "BREAKING CHANGE".
