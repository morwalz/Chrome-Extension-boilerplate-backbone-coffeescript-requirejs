# main.coffee requireJS bootloader file typically included in the index.html
require.config
  baseURL: 'dist/scripts',


  paths:
    jQuery: "../lib/js/jquery/jquery" # amd version
    Underscore: "../lib/js/underscore-amd/underscore" # amd version
    Backbone: "../lib/js/backbone-amd/backbone" # amd version
    text: "../lib/js/requirejs-text/text",

  shim:
    jQuery:
      deps: []
      exports: 'jQuery'
    Backbone:
      deps: ['jQuery', 'Underscore']
      exports: 'Backbone'
    Underscore:
      exports: '_'

  # start the main APP but let require also load any pre-app config and teh book and other apps
  require ["app"], (Office) ->
    officeApp = new Office();
    officeApp

