module.exports = {
  module: {
    rules: [
      {
        test: /\.scss$/,
        use: [
          { loader: 'vue-style-loader' },
          {
            loader: 'css-loader',
            options: {
              modules: true,
              localIdentName: '[name]__[local]___[hash:base64:5]',
            },
          },
          { loader: 'sass-loader' },
        ],
      },
    ],
  },
};
  