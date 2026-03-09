---
name: deploy
description: "Deployment workflow"
disable-model-invocation: true
argument-hint: "[environment]"
context: fork
agent: devops-engineer
---

Deploy to $ARGUMENTS environment.
If no environment is specified, default to the staging environment. If no deployment config exists, help create one.

Check deployment prerequisites, run pre-deploy checks, execute deployment, verify deployment status. If no specific deployment config exists, help set one up.

Safety checklist:
1. All tests pass on the target branch
2. No uncommitted changes
3. Deployment config exists and is valid
4. Environment variables and secrets are configured (never hardcode)
5. Rollback plan is identified before proceeding
6. Post-deploy health check confirms the deployment is working
