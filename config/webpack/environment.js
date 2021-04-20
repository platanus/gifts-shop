const { environment } = require('@rails/webpacker');
const { VueLoaderPlugin } = require('vue-loader');
const path = require('path');
const vue = require('./loaders/vue');

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin());
environment.loaders.prepend('vue', vue);
environment.config.merge({
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js',
      assets: path.resolve('./app/assets'),
    },
  },
});
module.exports = environment;
