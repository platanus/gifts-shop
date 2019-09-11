module.export = {
  test: /\.scss$/,
  use: [
      'vue-style-loader',
      'css-style-loader',
      'sass-loader',
  ],
};
