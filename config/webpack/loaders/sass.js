module.exports = {
  test: /\.scss$/,
  use: [
      'vue-style-loader',
      'css-style-loader',
      'sass-loader',
  ],
};
  