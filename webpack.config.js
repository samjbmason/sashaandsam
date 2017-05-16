const path = require('path')
const webpack = require('webpack')
const precss = require('precss')
const autoprefixer = require('autoprefixer')
const mqpacker = require('css-mqpacker')
const ExtractTextPlugin = require('extract-text-webpack-plugin')

module.exports = {
  devtool: 'eval',
  entry: [
    './source/js/index'
  ],
  output: {
    path: path.join(__dirname, '.tmp'),
    filename: 'bundle.js',
    publicPath: '/'
  },
  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    }),
    new ExtractTextPlugin('style.css')
  ],
  module: {
    loaders: [{
      test: /\.js$/,
      loaders: ['babel'],
      exclude: /node_modules/,
      include: path.join(__dirname, 'source','js')
    }, {
      test: /\.css$/,
      loader: ExtractTextPlugin.extract('style-loader', ['css-loader', 'postcss-loader'])
    }, {
      test   : /\.(ttf|eot|svg|woff(2)?)(\?[a-z0-9=&.]+)?$/,
      loaders : ['file-loader']
    }]
  },
  postcss: function () {
    return [precss, autoprefixer, mqpacker]
  }
}
