#Incude all the models here, then pass them back into the object
define(['jquery'
        'Underscore'
        'Backbone'
        '../views/view'
        'text!../tmpl/login.ejs'], ($, _, Backbone, View, templateText) ->

  class LoginView extends View

    className: "login-view"

    initialize: ->
      _.bindAll.apply _, [@].concat _.functions @
      # Compile the template for future use
      @template = _.template(templateText)
      @render()

    # Renders the actual view from the template
    render: ->
      @$el.html @template()
      @
)