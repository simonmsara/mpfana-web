import { defineConfig } from '@playwright/test';

export default defineConfig({
    testDir: './tests',

    use: {
        baseURL: 'http://localhost:3000',
    },

    webServer: {
        command: 'npm run dev',
        url: 'http://localhost:3000',
        timeout: 60_000,
        reuseExistingServer: !process.env.CI,
    },
});
