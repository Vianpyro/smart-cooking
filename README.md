# SmartCooking

A community recipe-sharing web app. Rust API (Axum) backed by PostgreSQL,
SvelteKit frontend, S3-compatible object storage for recipe images.

No application code exists yet — this repository currently holds only the
development tooling and an empty crate/route skeleton.

## Layout

```
crates/domain/    entities and business rules, no I/O
crates/storage/   sqlx repositories, DB mapping
crates/api/       axum binary: routing, DTOs, auth
web/              SvelteKit frontend
migrations/       sqlx migrations (DDL only)
fixtures/         seed data for local dev, applied explicitly
docs/             Typst design documents
```

See [CLAUDE.md](CLAUDE.md) and [web/CLAUDE.md](web/CLAUDE.md) for the rules
this codebase is built to.

## Prerequisites

- Rust 1.98.0 (installed automatically by `rustup` via `rust-toolchain.toml`)
- Node.js 24
- Docker with Compose v2
- `sqlx-cli`: `cargo install sqlx-cli --no-default-features --features rustls,postgres`
- Typst 0.15.1, if working on `docs/`

Or open the repository in the provided dev container
(`.devcontainer/`), which has all of the above preinstalled.

## Getting started

```bash
cp .env.example .env        # then fill in every <REPLACE_ME>
docker compose up -d        # postgres + object storage
cargo sqlx migrate run      # once migrations exist
cd web && npm ci
```

Run the API: `cargo run -p smart-cooking-api`
Run the frontend: `cd web && npm run dev`

## Checks

Every check below is exactly what CI runs (`.github/workflows/ci.yml`).

Rust:

```bash
cargo fmt --all --check
cargo clippy --workspace --all-targets --locked -- -D warnings
cargo test --workspace --locked
cargo doc --workspace --no-deps --locked
cargo sqlx prepare --workspace   # after changing any query! macro
```

Web (from `web/`):

```bash
npm run check
npm run lint
npm run test
npm run build
```

Docs: compile every file under `docs/` with `typst compile <file>.typ`.

Dependency and secret hygiene (also run in CI):

```bash
cargo deny check
cargo audit
cargo machete
typos
gitleaks detect --source . --log-opts=--all
```

Enable local pre-commit checks (fmt, clippy, web lint on changed files,
gitleaks) once with:

```bash
git config core.hooksPath .githooks
```

## Repository settings

GitHub push protection and secret scanning are not configurable from a file
in this repo. Enable both under Settings -> Code security for this
repository.

## Deployment

Not set up yet — there is nothing to deploy. When it's needed: a
container image build for `crates/api`, a Node adapter deployment (or
container image) for `web/`, and a migration-apply step in the release
pipeline ahead of traffic cutover.

## License

AGPL-3.0-or-later. See [LICENSE](LICENSE).
