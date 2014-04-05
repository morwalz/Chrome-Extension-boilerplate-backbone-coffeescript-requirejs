# background.coffee requireJS bootloader file typically included in the index.html
require.config
  baseURL: 'scripts',


  paths:
    jquery: "../../lib/js/zepto/zepto" # amd version
    Underscore: "../../lib/js/underscore-amd/underscore" # amd version
    Backbone: "../../lib/js/backbone-amd/backbone" # amd version
    text: "../../lib/js/requirejs-text/text"
    ChromeExtension: "../chrome-extension"
    Config: "../config"
    Constants: "../constants"
    deffered : "../../lib/js/simply-deffered/deferred"

  shim:
    Constants:
      deps: ['Config']
    jquery:
      deps: []
      exports: '$'
      init: -> window.jQuery = $
    Backbone:
      deps: ['jquery', 'Underscore']
      exports: 'Backbone'
    Underscore:
      exports: '_'
    deffered:
      deps: ['jquery']
      exports: 'Deffered'


# start the main APP but let require also load any pre-app config and teh book and other apps
  require ["app"], (Office) ->
    window.OH = {
      verbose: "vvv"
    }
    officeApp = new Office();
    officeApp
