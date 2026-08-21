# CLAUDE.md — web/

SvelteKit frontend for SmartCooking. Read the repository root `CLAUDE.md` first;
this file only covers what is specific to the frontend. English only.

## Commands

```
npm run dev
npm run build
npm run check          # svelte-check, type errors are failures
npm run lint
npm run test
```

## Rendering

- SSR is the default and the reason this stack was chosen. Do not opt a route out
  of SSR without stating the reason in the same change.
- Data loading belongs in `+page.server.ts` / `+layout.server.ts`. Do not fetch
  API data from component `onMount` for content that should be in the first
  paint or indexed by search engines.
- Recipe pages are the SEO surface. They must render fully server-side, with
  correct `<title>`, meta description, and Recipe structured data.
- Target first contentful paint under 1.5s on 4G. Ship no client JS a route does
  not need.

## API access

- The backend is a separate Axum service. Never assume same-process access.
- Server-side loads call the API with the request's session cookie forwarded.
  Browser code calls the API only for genuinely interactive actions.
- The API base URL comes from an environment variable. Never hardcode a host.
- Types describing API responses live in one place under `src/lib/api/`. Do not
  redefine a response shape inline in a component.
- Handle the failure path explicitly: a failed load renders an error state, never
  a blank page or a silent empty list.

## Security

- Never put a secret in anything reachable from client code. Only `PUBLIC_`
  prefixed environment variables are safe to reference in components; treat any
  other variable as server-only.
- Session cookies are set by the API and are `HttpOnly`. The frontend never reads
  or stores a token in `localStorage`.
- Never render user-submitted content with `{@html}`. Recipe titles, steps, and
  bios are untrusted text. If rich text is ever required, sanitize server-side
  and raise it as a design decision first.
- Form actions must validate server-side. Client validation is UX only.
- No user-identifying data in analytics, logs, or query strings.

## UI

- Mobile-first. Design at the small breakpoint, then widen.
- Tap targets at least 44x44px. Primary actions reachable at the bottom of the
  screen, never only at the top.
- No hover-only interaction. Every hover affordance has a tap equivalent.
- Cooking mode: full screen, large type (18pt minimum for steps), wake lock
  active, resilient to the screen being touched with messy hands.
- Images: responsive `srcset`, AVIF/WebP, explicit dimensions to avoid layout
  shift. Never crop a recipe photo.
- Accessibility is not optional: semantic elements, real labels, visible focus,
  contrast checked. Do not silence `svelte-check` a11y warnings — fix them.
- Every list view has a designed empty state and a designed error state.

## Style

- One component, one responsibility. Extract when a component exceeds roughly
  150 lines or handles two unrelated concerns.
- Shared primitives in `src/lib/components/`. Route-specific components stay
  beside their route.
- Derive state rather than duplicating it. No state that can drift from its
  source.
- ASCII in filenames. Component files in `PascalCase.svelte`.
- Do not add a UI dependency for something a few lines of CSS would do.
