# Security

## Secrets Management
- Never hardcode secrets, tokens, API keys, or passwords in source code.
- Use environment variables or a secrets manager. Reference `.env.example` for required vars.
- Never log sensitive data (tokens, passwords, PII).

## Input Handling
- Validate and sanitize all external input at system boundaries.
- Use parameterized queries — never build queries via string concatenation.
- Treat all user input as untrusted, including headers and query params.
- Guard against all injection types: SQL, NoSQL, XSS, command injection, path traversal, template injection.
- Reference: OWASP Top 10 (https://owasp.org/www-project-top-ten/) as the baseline checklist.

## Access & Communication
- Follow the principle of least privilege for all access grants.
- Use HTTPS/TLS for all external communication.
- Authenticate and authorize every request to protected resources.

## Dependencies
- Keep dependencies updated. Review changelogs for security patches.
- Audit new dependencies before adding — prefer well-maintained, widely-used packages.
- Pin dependency versions to avoid unexpected changes.
