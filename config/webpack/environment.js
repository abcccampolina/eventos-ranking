const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  Popper: ['popper.js', 'default'],
  $: 'jquery',
  jQuery: 'jquery',
  'window.jQuery': 'jquery',
  'window.$': 'jquery'
}))

module.exports = environment


// var config = Encore.getWebpackConfig();

// config.module.rules.unshift({
//   parser: {
//     amd: false,
//   }
// });

// module.exports = config;
