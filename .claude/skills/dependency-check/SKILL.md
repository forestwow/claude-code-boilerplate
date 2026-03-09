---
description: "Check for outdated and vulnerable dependencies"
context: fork
agent: security-auditor
---

Check all project dependencies for known vulnerabilities and outdated versions. Detect the package manager (npm/yarn/pnpm, pip/poetry, go mod, cargo, bundler) and run appropriate audit commands. Report: critical vulnerabilities, outdated major versions, deprecated packages. Suggest specific upgrade commands.
