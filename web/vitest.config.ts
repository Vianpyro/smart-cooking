import { defineConfig } from 'vitest/config';

export default defineConfig({
	test: {
		expect: { requireAssertions: true },
		passWithNoTests: true,
		environment: 'node',
		include: ['src/**/*.{test,spec}.{js,ts}']
	}
});
