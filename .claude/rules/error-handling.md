# Error Handling

## Core Principles
- Handle errors explicitly. Never silently swallow errors.
- Fail fast: validate inputs early, return or throw early.
- Distinguish recoverable errors from unrecoverable ones — handle each appropriately.

## Error Structure
- Use structured errors with context: error type, message, and cause.
- Use specific error types, not generic `Error` or `Exception`.
- Include enough context in errors for the caller to make a decision.

## Logging & Debugging
- Log errors with sufficient context for debugging (what happened, where, with what input).
- Include correlation IDs or request context when available.
- Do not expose internal error details to end users.

## Resource Safety
- Clean up resources in error paths using `finally`, `defer`, `with`, or equivalent.
- Ensure connections, file handles, and locks are released even when errors occur.
- Wrap external calls (network, DB, file I/O) with proper error handling.
