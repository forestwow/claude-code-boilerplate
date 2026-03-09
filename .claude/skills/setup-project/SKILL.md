---
description: "Customize this boilerplate for your project"
---

Help customize the Claude Code boilerplate for this project.

Steps:

1. Detect the project's language, framework, and tooling by checking config files (package.json, pyproject.toml, go.mod, Cargo.toml, Makefile, etc.)
2. Ask the user for: project name, description, tech stack summary, and key conventions
3. Fill in the `{{placeholders}}` in CLAUDE.md with actual values:
   - `{{PROJECT_NAME}}` — project name
   - `{{DESCRIPTION}}` — one-line description
   - `{{TECH_STACK}}` — languages, frameworks, databases
   - `{{BUILD_CMD}}` — build command (e.g., `npm run build`)
   - `{{TEST_CMD}}` — test command (e.g., `npm test`)
   - `{{LINT_CMD}}` — lint command (e.g., `npm run lint`)
   - `{{FORMAT_CMD}}` — format command (e.g., `npm run format`)
   - `{{ARCHITECTURE_NOTES}}` — brief architecture overview
4. Update hook scripts if needed for the detected tooling
5. Suggest which agents and skills are most relevant for this stack
6. Remove any agents that are irrelevant to the detected stack
7. Verify the setup is complete by checking no `{{` placeholders remain
