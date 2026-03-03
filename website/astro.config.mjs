// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

// https://astro.build/config
export default defineConfig({
  site: 'https://wbhinton.github.io',
  base: '/ELRS-Mobile',
  integrations: [
    starlight({
      title: 'ELRS Mobile',
      description: 'Advanced WiFi Flashing and Configuration for ExpressLRS',
      logo: {
        src: './src/assets/logo.png',
      },
      social: [
        {
          label: 'GitHub',
          href: 'https://github.com/wbhinton/ELRS-Mobile',
          icon: 'github',
        },
      ],
      customCss: ['./src/styles/custom.css'],
      sidebar: [
        {
          label: 'Guides',
          autogenerate: { directory: 'guides' },
        },
      ],
    }),
  ],
});