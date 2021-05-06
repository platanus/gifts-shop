const dotenv = require('dotenv');

const paths = [
  '.env.local',
  `.env.${process.env.NODE_ENV}`,
  '.env',
];
paths.forEach(path => {
  dotenv.config({ path, silent: true });
});

process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const environment = require('./environment');

module.exports = environment.toWebpackConfig();
