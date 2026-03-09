# Testing

## Test Structure
- Follow the AAA pattern: Arrange, Act, Assert — clearly separated.
- One behavior per test. If a test name has "and" in it, split it.
- Use descriptive test names that read as behavior specifications.

## Test Philosophy
- Test behavior, not implementation details.
- Meaningful coverage over 100% coverage — focus on critical paths and edge cases.
- Tests must be deterministic. No flaky tests. No reliance on timing or external state.

## Test Data
- Use fixtures and factories for test data setup.
- Avoid hardcoded magic values — use named constants or builders.
- Each test should set up its own state; never depend on test execution order.

## Workflow
- Always run tests after writing them — never assume they pass.
- Write the failing test first when fixing a bug.
- Keep tests fast. Slow tests get skipped; skipped tests rot.

## Mocking & Isolation
- Mock external services (APIs, databases, file systems) at the boundary.
- Prefer dependency injection over monkey-patching for testability.
- Use the project's existing mock/stub patterns — check test helpers first.
