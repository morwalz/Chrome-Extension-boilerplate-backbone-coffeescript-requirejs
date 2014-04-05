# background.coffee requireJS bootloader file typically included in the index.html
console.log 'loading start ' + new Date()
require.config
  baseURL: 'scripts',
  map :
    '*': { 'jQuery': 'jquery' }

  paths:
    zepto: "../../lib/js/zepto/zepto.custom" # amd version
    jquery: "../../lib/js/zepto/zepto-jquery" # amd version
    Underscore: "../../lib/js/underscore-amd/underscore" # amd version
    Backbone: "../../lib/js/backbone-amd/backbone" # amd version
    Bootstrap: "../../lib/js/bootstrap/bootstrap.custom"
    text: "../../lib/js/requirejs-text/text"
    Config: "../config"
    Constants: "../constants"
    ChromeExtension: "../chrome-extension"
    googleAnalytics : "../../lib/asyncTracking"

  shim:
    Constants:
      deps: ['Config']
    jquery:
      deps: ['zepto']
      exports: 'jQuery'
    Backbone:
      deps: ['jquery', 'Underscore']
      exports: 'Backbone'
    Underscore:
      exports: '_'

    Bootstrap:
      deps: ['jQuery']

    googleAnalytics:
      exports: 'googleAnalytics'

  # start the main APP but let require also load any pre-app config and teh book and other apps
  require ["app"], (Office) ->
    window.OH = {
      verbose: "vvv"
    }

    officeApp = new Office();
    console.log 'loading end ' + new Date()
    officeApp


