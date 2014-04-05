#Main Shark Application file
define(['jquery'
        'Underscore'
        'Backbone',
        'deffered',
        'Constants' ,
        'ChromeExtension',
        ], ($, _, Backbone, Deffered, Constants, ChromeExtension) ->

  class Office extends Backbone.Model
    #All the router's initialize function
    ##this file is entry point to all backgrpound task for chrome extensiosns
    initialize: ->

      window.logger = console

      # Set app to the global Office reference
      window.Office = @

      @.isPopUpRunning = false
      console.log "hello from background app"
      # Setup the session
      # User settings setup and listeners

    popUpRunning: (status)->
      if status?
        @.isPopUpRunning = status
      @.isPopUpRunning


  Office
)