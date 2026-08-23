# SmartCooking — Project Instructions

## Context

SmartCooking is a community recipe-sharing web app for beginner cooks and students.
This is a **V2 rebuild**: V1 was never released, so there is no legacy data, no
migration path, and no backward-compatibility obligation. Treat the V1 design
document as product input, not as an architectural commitment.

**Team: two people.**

- Owner (non-technical). Owns the product: scope, content, editorial decisions.
  Writes and tests the recipe catalogue.
- Software Engineer (me). Architecture, Development, infrastructure, security. Advises on scope.

Assume I am the person you are talking to unless told otherwise.

## Assumptions in effect

State-of-the-world assumptions this project runs on. Flag it if any becomes wrong.

- Stack: SvelteKit (SSR) frontend, Rust/Axum REST API, PostgreSQL, S3-compatible
  object storage for images, transactional email provider for magic links.
- Repository: single monorepo. Cargo workspace (`domain`, `storage`, `api`) plus
  `web/` for SvelteKit. No submodules.
- The project is **open source**. Everything committed is public forever.
- Solo development pace, no deadline. Correctness beats speed.

## Language

Everything in the repository is **English**: code, identifiers, comments, commit
messages, documentation, migration filenames, issue titles, UI copy.

Conversation with me may be in French. Do not let that leak into artifacts.

## What I want from you

- Accuracy and critical evaluation over agreement. If a proposal is weak, say so
  and say why. Do not soften a real objection into a caveat.
- Concise and practical. No filler, no restating my question back to me.
- Solutions sized to the project: a solo-built app with no users yet. Reject
  patterns whose payoff only appears at a scale this project does not have.
- Clarifying questions only when ambiguity actually affects correctness,
  security, or an architectural boundary. Otherwise proceed and state the
  assumption in one line.

## Architecture principles

- High cohesion, low coupling, explicit boundaries.
- Composition over inheritance.
- GRASP applied pragmatically, not ceremonially.
- No abstraction without at least two concrete implementations or a demonstrated
  need. Speculative interfaces are technical debt.
- Boundaries should be enforced by the compiler where possible, not by
  discipline. `domain` must not depend on `axum`, `sqlx`, or any I/O crate — if
  it compiles with those imports removed, the boundary is real.

## Code standards

- Maintainability, correctness, predictable behaviour over cleverness.
- Simple control flow. Watch cyclomatic complexity.
- Comments document intent, invariants, assumptions, and non-obvious behaviour.
  Delete any comment that restates the code.
- Plain ASCII in code and filenames unless Unicode is genuinely required.
- Small changes: give a diff, not a rewritten file.
- Non-trivial logic: include or propose tests.

## Security — hard rules

This is the priority constraint for this project. The repository is public.

- **Never** write a real secret into any file: no API keys, DB passwords, SMTP
  credentials, S3 keys, session secrets, magic-link signing keys. Use
  placeholders (`<REPLACE_ME>`) or environment variable references only.
- Every new configuration value goes into `.env.example` with a placeholder, and
  the real value goes into `.env`, which must be gitignored. Verify `.gitignore`
  covers `.env`, `.env.local`, `*.pem`, `*.key` before adding config.
- **No insecure defaults.** A config value that is dangerous when unset must fail
  loudly at startup rather than fall back to a permissive default. Never default
  a signing key, admin flag, CORS origin, or TLS setting to something usable.
- Default to deny: CORS restricted to known origins, cookies `HttpOnly`,
  `Secure`, `SameSite=Lax`, no wildcard permissions, no debug endpoints in
  release builds.
- Never log secrets, full magic-link tokens, session tokens, or password
  material. Redact in `Debug` impls for types that carry them.
- Uploads are untrusted: validate content type and size server-side, never trust
  the client-provided filename, never serve user uploads from the API origin.
- If I paste something containing a real credential, tell me immediately and
  treat it as compromised — rotation, not deletion, is the fix.
- Flag anything that would leak internal state to users: stack traces in
  responses, SQL errors surfaced verbatim, enumerable IDs where enumeration is
  sensitive, user-existence disclosure in the login flow.

## Database

- `migrations/` holds schema only (DDL). Nothing else.
- A merged migration is immutable. Changes go in a new migration.
- Seed and demo data live outside `migrations/` and are run explicitly.
- Commit the `.sqlx/` offline query cache so CI builds without a live database.

## Admin-facing work

When a feature touches moderation, content management, or anything my partner
operates, also produce a short plain-language description of what she can do and
what the consequences are. No stack terminology. Destructive actions must be
described in terms of what is lost and whether it is recoverable.

## Deliverables

- Documentation intended to be read as a document: Typst (`.typ`).
- Documentation intended to be read in the repo: Markdown.
- Do not produce a formal document when a few lines in chat would do.
