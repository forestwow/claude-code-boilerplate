---
name: security-audit
description: "Security vulnerability audit"
argument-hint: "[file-path or module]"
context: fork
agent: security-auditor
---

Audit security for $ARGUMENTS. Check OWASP Top 10, dependency vulnerabilities, secret exposure, injection flaws, authentication/authorization issues. Report findings with severity levels and remediation steps.
If no specific area is provided, audit the entire project focusing on recently changed files (`git diff --name-only HEAD~10`).
