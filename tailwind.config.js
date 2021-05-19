/* eslint-disable no-undef */

module.exports = {
  theme: {
    fontSize: {
      xs: '12px',
      sm: '14px',
      base: '16px',
      lg: '18px',
      xl: '20px',
      '2xl': '24px',
      '3xl': '30px',
      '4xl': '36px',
      '5xl': '48px',
    },
    extend: {
      colors: {
        'gf-purple': {
          light: '#f1f0fa',
          DEFAULT: '#aca2ff',
        },
        'gf-emerald': '#50cbb6',
        'gf-gray': {
          DEFAULT: '#979797',
          dark: '#545454',
        },
      },
      fontFamily: {
        sans: ['Open Sans', 'sans-serif'],
        title: ['PT Sans Caption', 'sans-serif'],
        roboto: ['Roboto', 'sans-serif'],
      },
    },
  },
  variants: {},
  plugins: [],
  purge: [
    './app/**/*.vue',
    './app/**/*.html',
    './app/**/*.html.erb',
  ],
};
