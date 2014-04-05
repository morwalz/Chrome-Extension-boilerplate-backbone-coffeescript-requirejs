#Incude all the models here, then pass them back into the object
define(['jquery'
        'Underscore'
        'Backbone'
        '../views/view'
        '!text!../tmpl/loading.ejs'], ($, _, Backbone, View, loadingTemplateText) ->

  class LoadingView extends View

    isLoading: true

    className: 'initial-loading'

    initialize: ->
      _.bindAll.apply _, [@].concat _.functions @
      @template = _.template loadingTemplateText

      Office.on 'loading-update', (percent) ->
        @updateLoading percent

      Office.on 'doneLoading', =>
        @updateLoading 100

      @render() # Render out the view

    doneLoading: ->
      @isLoading = false

    updateLoading: ( percent ) =>
      if @isLoading
        @$el.find('.bar').css({width: "#{@percent}%"})
        @doneLoading() if @percent >= 100

    # Renders the actual view from the template
    render: =>
      @$el.html @template
      @updateLoading 5

    dispose: ->
      super

  # Whatever is returned here will be usable by other modules
  LoadingView
)

