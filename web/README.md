# web

Astro frontend for SmartCooking. See [CLAUDE.md](CLAUDE.md) for the rules this
frontend is built to.

## Developing

```sh
npm install
npm run dev
```

## Building

```sh
npm run build
```

This produces a static site under `dist/`, ready to serve from any static
host (GitHub Pages in this project — see `CLAUDE.md`). There is no server
build and no adapter: `output: 'static'` in `astro.config.mjs` is the whole
deployment story.

You can preview the production build with `npm run preview`.
