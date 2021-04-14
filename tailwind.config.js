/* eslint-disable no-undef */

module.exports = {
  theme: {
    fontSize: {
      '3xs': '12px',
      '2xs': '15px',
      xs: '16px',
      sm: '18px',
      md: '20px',
      lg: '22px',
      xl: '25px',
      '2xl': '30px',
      '3xl': '40px',
    },
    extend: {
      colors: {
        primary: '#35c6ad',
        secondary: '#0088D7',
        background: '#f4f8f8',
        'gf-purple': {
          lighter: '#fef1fd',
          light: 'dfdbff',
          DEFAULT: 'aca2ff',
          dark: '8376eb',
          darker: '585268',
        },
        'gf-red': 'ff855f',
        'gf-gray': '979797',
        'gf-blue': '64abff',
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
