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
        primary: '#35c6ad',
        secondary: '#0088D7',
        background: '#f4f8f8',
        'gf-purple': {
          lighter: '#fef1fd',
          light: '#dfdbff',
          DEFAULT: '#aca2ff',
          dark: '#8376eb',
          darker: '#585268',
        },
        'gf-red': '#ff855f',
        'gf-gray': '#979797',
        'gf-blue': '#64abff',
      },
      fontFamily: {
        sans: ['Open Sans', 'sans-serif'],
        title: ['PT Sans Caption', 'sans-serif'],
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
