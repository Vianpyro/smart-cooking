# CLAUDE.md — web/

Astro frontend for SmartCooking. Read the repository root `CLAUDE.md` first;
this file only covers what is specific to the frontend. English only.

## Architecture

Static site. `output: 'static'`, built in CI, deployed to GitHub Pages under a
custom domain. **No Node runtime in production**, no SSR, no server endpoints.

The Axum API is self-hosted on a separate host and is the only source of dynamic
data. Recipes, tags, and everything else in the catalogue are fetched from it by
the browser at runtime — not baked in at build time. The build has no database
access and must never be given any.

Consequences to keep in mind rather than rediscover:

- A recipe published by the owner appears immediately, with no rebuild. Never
  introduce a pattern that requires redeploying to publish content.
- The first byte the browser receives is an empty shell. Search engines see
  little. This is an accepted trade-off, recorded in the vision document — do
  not try to work around it with build-time data fetching.
- GitHub Pages cannot route client-side paths. A deep link like
  `/recipes/carbonara` reaches Pages before any JS runs, so a `404.html`
  fallback identical to the entry document is required. Verify deep links
  actually work after any routing change.

## Commands

```
npm run dev
npm run build
npm run preview
npm run check          # astro check, type errors are failures
npm run lint
npm run test
```

## Islands

Astro ships zero JavaScript by default. Keep it that way.

- Static content — recipe text, listings, navigation — is plain `.astro` with no
  client directive.
- Add an island only where interaction genuinely requires it: filters, the
  servings scaler, cook mode, the admin forms.
- Prefer `client:visible` or `client:idle` over `client:load`. Reach for
  `client:load` only when the island must be interactive before first paint, and
  say why in a comment.
- Do not add a UI framework to render something static. If a component has no
  state and no event handlers, it should not be an island.

## API access

- Base URL comes from an environment variable, never a hardcoded host. Only
  `PUBLIC_` variables reach the browser; that is the whole configuration surface
  available to client code.
- Response types live in one place under `src/lib/api/`. Do not redefine a
  response shape inline in a component.
- Every fetch has an explicit failure path. A failed request renders an error
  state; never a blank page, never a silently empty list.
- Loading states are required, not optional — the data arrives after paint, so
  every data-driven view has a visible loading state by construction.

## Security

The frontend is fully public and fully untrusted. Everything it does can be
replayed by hand against the API.

- No secret is reachable from client code. There is no server side here to hide
  one in. Any value the frontend can read is public.
- **Authorisation is the API's job.** Hiding an admin control in the UI is
  presentation, not security. Never treat "the request came from the admin
  route" as authentication.
- Session cookies are set by the API and are `HttpOnly`; the frontend cannot and
  must not read them, and must never store a token in `localStorage`.
- Front and API must be same-site (`app.example.com` and `api.example.com`) so
  `SameSite=Lax` holds. If they ever diverge to different sites, cookies need
  `SameSite=None; Secure` plus explicit CSRF protection — raise this rather than
  changing the cookie flags to make something work.
- Never render user-submitted content with `set:html`. Recipe titles, steps, and
  bios are untrusted text. If rich text becomes necessary, sanitize server-side
  and raise it as a design decision first.
- Client-side form validation is UX only. The API validates independently.
- No user-identifying data in analytics, logs, or query strings. Third-party
  trackers are out of scope by default.

## Admin

`/admin` is part of this site. It is a thin client over the API: forms in,
requests out, no logic that the API does not also enforce.

- Plain forms and standard controls. No component library, no design system.
- Recipe editing is the one screen where real interactivity is justified
  (dynamic ingredient rows, reorderable steps, image upload). Everything else —
  listing, publishing, unpublishing, tag management — should be as close to
  plain HTML as it can be.
- Destructive actions require confirmation and must state what is lost and
  whether it is recoverable, in plain language, with no stack terminology.

## UI

- Mobile-first. Design at the small breakpoint, then widen.
- Tap targets at least 44x44px. Primary actions reachable at the bottom of the
  screen, never only at the top.
- No hover-only interaction. Every hover affordance has a tap equivalent.
- Cooking mode: full screen, large type (18pt minimum for steps), wake lock
  active, resilient to a screen being touched with messy hands.
- Images: responsive `srcset`, AVIF/WebP, explicit dimensions to avoid layout
  shift. Never crop a recipe photo.
- Accessibility is not optional: semantic elements, real labels, visible focus,
  contrast checked. Do not silence `astro check` a11y warnings — fix them.
- Every list view has a designed empty state and a designed error state. The
  catalogue starts small, so the empty state is a real screen, not a corner case.

## Style

- One component, one responsibility. Extract when a component exceeds roughly
  150 lines or handles two unrelated concerns.
- Shared primitives in `src/components/`. Page-specific components stay beside
  their page.
- Derive state rather than duplicating it. No state that can drift from its
  source.
- ASCII in filenames. Components in `PascalCase.astro`.
- Do not add a dependency for something a few lines of CSS would do.
