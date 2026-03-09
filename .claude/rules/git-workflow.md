# Git Workflow

## Commit Messages
- Use conventional commits: `type(scope): description`
- Types: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`, `perf`, `ci`
- Commit messages explain "why" the change was made, not "what" changed.
- Keep the subject line under 72 characters.

## Commit Scope
- Atomic commits: one logical change per commit.
- Never mix refactoring with behavior changes in the same commit.
- Never commit generated files, build artifacts, or secrets.

## Branching
- Branch naming: `type/short-description` (e.g., `feat/user-auth`, `fix/login-redirect`).
- Keep branches short-lived. Merge or rebase frequently.

## Before Committing
- Always review changes before committing (`git diff`).
- Ensure tests pass and linting is clean.
- Stage files explicitly — avoid blanket `git add .` to prevent accidental inclusions.
