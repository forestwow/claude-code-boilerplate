# Code Quality

## Naming & Clarity
- Write self-explanatory code; variable and function names must convey intent.
- All code, naming, and variables must be in English only.
- Prefer simple, readable solutions over clever ones.

## Comments
- Minimal comments: only explain non-obvious "why", never "what" the code does.
- If code needs a comment to explain what it does, rewrite the code instead.
- Good: `// Retry 3x because the payment gateway has transient 503s under load`
- Bad: `// Loop through the array and check each item`

## Structure
- Functions should do one thing well (single responsibility).
- Keep files focused and cohesive — one module, one concern.
- Prefer small functions with clear inputs and outputs.

## Hygiene
- No dead code. No commented-out code. Delete it; git has history.
- Remove unused imports, variables, and dependencies.
- Consistent formatting — follow the project's established style.

## Adapting to Existing Projects
- Before writing new code, study the existing codebase patterns: naming conventions, file structure, error handling style, and test patterns already in use.
- Match the existing project's style even if it differs from these defaults. Consistency within a project outweighs theoretical best practices.
- When the project has an established pattern (e.g., callbacks instead of async/await, classes instead of functions), follow that pattern in new code unless explicitly asked to modernize.
- For legacy codebases without linters or formatters, do not introduce new tooling unless asked. Write code that fits the existing style.
