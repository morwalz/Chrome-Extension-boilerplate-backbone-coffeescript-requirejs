define(['jquery'
        'Underscore'
        'Backbone'], ($, _, Backbone) ->

  class Router extends Backbone.Router

    initialize: () ->
      Office.router = @
      console.log 'router intialized'

      Office.on 'doneLoading', () =>
        console.log '[app] done loading' if OH?.verbose?.match /v/i

      @startShow()


    startShow: ->
      try
        Backbone.history.stop()
      catch error
        console.log error if OH?.verbose?.match /v/i
      Backbone.history.start pushState: true, root: OH.baseDir||''


    #######################
    ## Home Controller
    #######################

    home: () ->
      console.log '[--Router--] running home' if OH?.verbose?.match /v/i
      console.log 'inside home router'
      Office.appView.showView 'home'

    loading: () ->
      console.log '[--Router--] running home' if OH?.verbose?.match /v/i
      Office.appView.showView 'loading'

  Router
)