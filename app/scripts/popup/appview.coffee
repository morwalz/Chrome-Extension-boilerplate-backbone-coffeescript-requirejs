#Incude all the models here, then pass them back into the object
define(['jquery'
        'Underscore'
        'Backbone'
        '../views/view'
        '../views/loading'
        '../views/home'
        'text!../tmpl/index.ejs'], ($, _, Backbone,View, LoadingView,HomeView, templateText) ->

  class AppView extends View
    el: $ '#app-container'

    loadingPercent: 0
    isLoading: true


    viewAttachTo:
      'loading'           : '#main-container'
      'home'              : '#main-container'

    initialize: ->
      _.bindAll.apply _, [@].concat _.functions @
      @template = _.template templateText

      @subview 'loading', new LoadingView
      @subview 'home', new HomeView

      @currentViewName = 'loading'
      @currentView = @subview @currentViewName

      @render() # Render out the view
      addEventListener 'unload', () =>
        @.teardown()


    routes:
      ''                           : 'home'
      '/'                          : 'home'
      'home'                       : 'home'

    # Renders the actual view from the template
    render: ->
      @$el.html @template
      @showView @currentViewName

  # Whatever is returned here will be usable by other modules
  AppView
)