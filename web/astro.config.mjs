import { defineConfig } from 'astro/config';

export default defineConfig({
	// No Node runtime in production, no SSR, no server endpoints (see CLAUDE.md).
	output: 'static'
});
