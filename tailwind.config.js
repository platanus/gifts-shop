/* eslint-disable no-undef */

module.exports = {
  theme: {
    extend: {
      colors: {
        primary: '#35c6ad',
        secondary: '#0088D7',
        background: '#f4f8f8',
      },
      fontFamily: {
        sans: ['Karla', 'sans-serif'],
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
