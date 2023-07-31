const { environment } = require('@rails/webpacker')

const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery/src/jquery',
  jQuery: 'jquery/src/jquery',
  Popper: ['popper.js', 'default'],
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
