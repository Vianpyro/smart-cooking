# CLAUDE.md

Guidance for Claude Code working in this repository.

## Project

SmartCooking: community recipe-sharing web app. Monorepo, solo developer, public
repository. Everything in this repo is written in **English**.

## Layout

```
Cargo.toml            # workspace manifest
crates/
  domain/             # entities, business rules. No I/O, no web, no SQL.
  storage/            # sqlx repositories, DB types, mapping to/from domain
  api/                # axum binary: routing, extractors, DTOs, auth
web/                  # Astro app (see web/CLAUDE.md)
migrations/           # sqlx migrations, DDL only
fixtures/             # seed data for local dev, never applied automatically
docs/                 # Typst design documents
```

## Dependency direction

`api` -> `storage` -> `domain`. Never the reverse, never a shortcut.

- `domain` depends on no I/O crate. If you find yourself adding `sqlx`, `axum`,
  `reqwest`, or `tokio` to `crates/domain/Cargo.toml`, the design is wrong —
  stop and raise it instead of adding the dependency.
- `storage` owns SQL. No SQL string appears in `api`.
- `api` owns HTTP. No `axum` type appears in `storage` or `domain`.
- DTOs are `api`-local and separate from domain entities, even when the fields
  currently match. They change for different reasons.

## Commands

```
cargo check --workspace
cargo clippy --workspace --all-targets -- -D warnings
cargo fmt --all
cargo test --workspace
cargo sqlx prepare --workspace     # after changing any query! macro
sqlx migrate add -r <name>
docker compose up -d               # postgres + object storage, local only
```

Run `clippy` and `fmt` before considering a change finished. Warnings are errors.

## Database rules

- `migrations/` contains DDL only: tables, columns, indexes, constraints,
  triggers. No `INSERT` of application data.
- A migration that has been committed to `main` is immutable. To change schema,
  add a new migration. Never edit or delete an existing one.
- Every migration has a reversible down-script unless genuinely impossible; say
  so in a comment when it is not.
- Regenerate and commit `.sqlx/` whenever compile-time-checked queries change.
- Seed data goes in `fixtures/` and is applied by an explicit command, never on
  startup and never in a migration.

## Security rules — non-negotiable

The repository is public. Assume every commit is permanent and world-readable.

- Never write a real credential into any tracked file. Use `<REPLACE_ME>`
  placeholders or `std::env::var`.
- Every new config value: add a placeholder line to `.env.example` in the same
  change. Real values live only in gitignored `.env`.
- Secrets are read at startup and **fail hard when missing**. No
  `unwrap_or("dev-secret")`, no `unwrap_or_default()` on a signing key, no
  permissive fallback for CORS origins or auth flags. A missing secret must
  abort the process with a clear message.
- Cookies: `HttpOnly`, `Secure`, `SameSite=Lax`. Sessions server-side.
- Never log secrets, session tokens, or full magic-link tokens. Types carrying
  secret material get a manual `Debug` impl that redacts.
- Error responses to clients carry no internal detail: no SQL text, no stack
  traces, no file paths. Log the detail server-side, return an opaque message
  and a correlation id.
- Auth endpoints must not disclose whether an account exists. Same response and
  comparable timing either way.
- Uploads: validate MIME and size server-side, generate the stored filename
  yourself, never serve user content from the API origin.
- All input validated at the `api` boundary before it reaches `domain`.

If a change would violate any of the above, stop and explain rather than
implementing it with a note.

## Code style

- Comments explain intent, invariants, assumptions, and non-obvious behaviour.
  No comment that restates the code.
- ASCII only in code and filenames.
- Prefer explicit error types (`thiserror`) over `anyhow` in library crates;
  `anyhow` is acceptable in the binary.
- No `unwrap()` or `expect()` in request-handling paths. Startup code may
  `expect()` with a message that says what the operator must fix.
- Keep functions small and control flow flat. Early returns over nesting.
- Tests for non-trivial logic. Domain rules are unit-tested without a database.

## Scope discipline

- Do not add an abstraction, trait, or layer without a concrete second use case.
- Do not add a dependency without saying what it replaces and why writing it
  ourselves is worse.
- Do not introduce caching, queues, background workers, or feature flags until
  there is a measured need.
- When a change is small, produce a diff rather than rewriting the file.
- Do not reformat or refactor code unrelated to the task at hand.

## Working style

Ask before proceeding only when the ambiguity affects correctness, security, or
a boundary between crates. Otherwise pick the reasonable option and state the
assumption in one line.
