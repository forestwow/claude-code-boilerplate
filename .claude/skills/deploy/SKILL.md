---
description: "Deployment workflow"
context: fork
agent: devops-engineer
---

Deploy to $ARGUMENTS environment.
If no environment is specified, default to the staging environment. If no deployment config exists, help create one.

Check deployment prerequisites, run pre-deploy checks, execute deployment, verify deployment status. If no specific deployment config exists, help set one up.
