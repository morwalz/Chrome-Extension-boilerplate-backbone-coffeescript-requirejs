#Main Shark Application file
define(['jquery'
        'Underscore'
        'Backbone',
        'Bootstrap'
        'Constants'
        'router',
        'ChromeExtension',
        'appview'
], ($, _, Backbone, Bootstrap, Constants, Router, ChromeExtension, AppView) ->

  class Office extends Backbone.Model
    #All the router's initialize function
    ##register all views and popup task in this file.
    initialize: ->
      console.log 'init start -> ' + new Date()
      ChromeExtension.popUpRunning true

      # Set app to the global Office reference
      window.Office = @

      #Start the Auth session

      # Get the authenticated user
      # Pull the collection of courses for this user
      # Setup the containing base view
      @.appView = new AppView()

      # Kickoff the router!
      @.router = new Router()
      init = ()=>
        console.log 'inside pop init'
        @.router.home()

      @.listenTo ChromeExtension.getBackgroundOfficeInstance(), 'reloadView', init


      init()

    configBasedSetup: =>
      # Any re-run setup based on any user-level configurations

    console.log 'init start -> ' + new Date()
    Office
)