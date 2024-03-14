import { defineConfig } from 'vitepress';

export default defineConfig({
  title: 'AuthRails',
  description: 'Simple authentication for Rails',
  srcDir: './src',
  base: '/auth_rails/',
  themeConfig: {
    nav: [
      {
        text: 'Guide',
        link: '/introduction/what-is-it',
      },
    ],
    sidebar: [
      {
        text: 'Introduction',
        items: [
          {
            text: 'What is AuthRails?',
            link: '/introduction/what-is-it',
          },
          {
            text: 'Getting Started',
            link: '/introduction/getting-started',
          },
        ],
      },
      {
        text: 'CLI',
        items: [
          {
            text: 'Configuration',
            link: '/cli/configuration',
          },
          {
            text: 'Migration',
            link: '/cli/migration',
          },
        ],
      },
      {
        text: 'Customization',
        items: [
          {
            text: 'Custom Strategy',
            link: '/customization/custom-strategy',
          },
          {
            text: 'Custom Response Data',
            link: '/customization/custom-response',
          },
          {
            text: 'Custom Password Validation',
            link: '/customization/custom-password-validation',
          },
          {
            text: 'Custom Identifier Column',
            link: '/customization/custom-identifier',
          },
          {
            text: 'Complex Retrieve Resource',
            link: '/customization/complex-retrieve-resource',
          },
        ],
      },
      {
        text: 'API Reference',
        link: '/api-reference',
      },
      {
        text: 'Changelogs',
        link: '/changelogs',
      },
    ],
    outline: {
      level: [2, 3],
      label: 'On this page',
    },
    lastUpdated: {
      text: 'Last updated',
      formatOptions: {
        dateStyle: 'full',
        timeStyle: 'medium',
      },
    },
    socialLinks: [
      {
        icon: 'github',
        link: 'https://github.com/zgid123/auth_rails',
      },
    ],
  },
});
