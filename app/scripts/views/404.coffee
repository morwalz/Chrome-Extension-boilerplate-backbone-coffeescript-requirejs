#Incude all the models here, then pass them back into the object
define(['jquery'
        'Underscore'
        'Backbone'
        '../views/view'
        'text!../tmpl/404.ejs'], ($, _, Backbone, View, templateText) ->

  class HomeView extends View

    className: 'error-view'

    initialize: ->
      _.bindAll.apply _, [@].concat _.functions @
      # Compile the template for future use
      @template = _.template(templateText)

    # Renders the actual view from the template
    render: ->
      @$el.html @template()

  # Whatever is returned here will be usable by other modules
  HomeView
)