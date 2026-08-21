# Migrations

Rules, not suggestions:

- DDL only: tables, columns, indexes, constraints, triggers. No `INSERT` of
  application data.
- A migration that has been merged to `main` is immutable. To change the
  schema, add a new migration; never edit or delete an existing one.
- Every migration has a reversible down-script, generated with
  `sqlx migrate add -r <name>`, unless reverting is genuinely impossible. If
  it is not reversible, say so in a comment in the down-script explaining why.
- Seed data lives in `fixtures/` and is applied by an explicit command. It is
  never applied automatically on startup and never belongs in a migration.

Apply pending migrations locally with:

```
cargo sqlx migrate run
```
