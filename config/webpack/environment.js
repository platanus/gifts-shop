const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const vue = require('./loaders/vue');
const sass = require('./loaders/sass');

environment.plugins.append('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.append('vue', vue);
environment.config.merge({
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
    },
  },
});
environment.loaders.append('sass', sass);
module.exports = environment;
