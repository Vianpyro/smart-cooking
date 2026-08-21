FROM mcr.microsoft.com/devcontainers/base:bookworm

# Rust and Node are installed by devcontainer Features (see devcontainer.json).
# This Dockerfile only covers tools that have no maintained Feature.

# PostgreSQL 18 client, matching the project's target server version exactly.
# Debian bookworm's own apt repo only ships an older client, so pull from PGDG.
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
        | gpg --dearmor -o /usr/share/keyrings/postgresql.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" \
        > /etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends postgresql-client-18 \
    && rm -rf /var/lib/apt/lists/*

# Typst, pinned to the version verified for this project (see CLAUDE.md).
ARG TYPST_VERSION=0.15.1
RUN curl -fsSL "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz" \
        | tar -xJ -C /usr/local/bin --strip-components=1 "typst-x86_64-unknown-linux-musl/typst"
