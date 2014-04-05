#Incude all the models here, then pass them back into the object
define(['jquery'
        'Underscore'
        'Backbone'
        '../models/model'], ($, _, Backbone, Model) ->

  class View extends Backbone.View

    subviews: []
    unnamedSubviews: []
    subviewsByName: {}

    currentView: null
    currentViewName: null

    viewAttachTo: {}

    model: new Model

    # Keep the element when disposing
    keepElement: false

    teardown: ->
      @dispose()
      @$el?.remove()

    trigger: (event, args...) ->
      super

      return if event.match /^parent:/ # only decend one level

      thisType = @__proto__?.constructor?.name
      if OH?.verbose?.match /vvvv/i
        console.log "[E][V][#{thisType}]:\t #{event}", args[0]?.__proto__?.constructor?.name

      return unless @subviews.length > 0
      for subview in @subviews
        subview.trigger 'parent:'+event, args...



    # Getting or adding a subview.
    subview: (name, view) ->

      if name and view
        # Add the subview, ensure it’s unique.
        @removeSubview name
        @.subviews = [] if not @.hasOwnProperty('subviews')
        @.subviewsByName = {} if not @.hasOwnProperty('subviewsByName')
        @.subviews.push view
        @.subviewsByName[name] = view
        view.parentView = @
        view.trigger 'parent:add'
        view
      else if name

        @.subviewsByName = {} if not @.hasOwnProperty('subviewsByName')
        # Get and return the subview by the given name.
        @subviewsByName[name]



    # Removing a subview.
    removeSubview: (nameOrView) ->
      return unless nameOrView
      subviews = @subviews
      byName = @subviewsByName

      if typeof nameOrView is 'string'
        # Name given, search for a subview by name.
        name = nameOrView
        view = byName[name]
      else
        # View instance given, search for the corresponding name.
        view = nameOrView
        for otherName, otherView of byName
          if view is otherView
            name = otherName
            break

      # Break if no view and name were found.
      return unless name and view and view.dispose

      view.dispose()

      # Remove the subview from the lists.
      index = _.indexOf subviews, view
      subviews.splice index, 1 if index isnt -1
      delete byName[name]


    showView: (nameOrView, destroyCurrent=false) ->
      return unless nameOrView
      subviews = @subviews
      byName = @subviewsByName
      if typeof nameOrView is 'string'
        # Name given, search for a subview by name.
        name = nameOrView
        view = byName[name]
      else
        # View instance given, search for the corresponding name.
        view = nameOrView
        for otherName, otherView of byName
          if view is otherView
            name = otherName
            break


      if OH?.verbose?.match /vv/i
        console.log "[View] Switching from: `#{@currentViewName}` to `#{name}`"

      @currentView.trigger 'hiding', @
      @currentView.undelegateEvents()

      if destroyCurrent and @currentViewName and @currentViewName isnt name
        console.log "[View] Removing old view `#{@currentViewName}`" if OH?.verbose?.match /vv/i
        oldViewName = @currentViewName
        @removeSubview oldViewName

      #Set the current view
      @currentView = view
      @currentViewName = name

      @currentView.trigger 'showing', @
      @currentView.delegateEvents()


      # Render te new view
      @attachView @currentViewName


    attachView: (nameOrView, render=true) ->
      subviews = @subviews
      byName = @subviewsByName
      console.log nameOrView
      console.log byName
      if typeof nameOrView is 'string'
        # Name given, search for a subview by name.
        name = nameOrView
        view = byName[name]
      else
        # View instance given, search for the corresponding name.
        view = nameOrView
        for otherName, otherView of byName
          if view is otherView
            name = otherName
            break

      view.render() if render

      view.delegateEvents()
      console.log name + ' -> ' + @viewAttachTo[name]
      console.log @$el
      console.log @$el.find(@viewAttachTo[name])
      @$el.find(@viewAttachTo[name]).html view.$el

      if OH?.verbose?.match /vv/i
        console.log "attaching #{name} to #{@viewAttachTo[name]}"

      view.trigger 'onShow'

      if OH?.verbose?.match /vv/i
        console.log "attaching #{name} to #{@viewAttachTo[name]}"

    changeModel: (newModel) ->
      if @model
        @.model.set newModel.toJSON()
      else
        @.model = newModel
      @

    replaceModel: (newModel) ->
      @.model = newModel



    # Disposal
    # --------
    disposed: false
    dispose: ->
      return if @disposed
      # Dispose subviews.

      if @.hasOwnProperty('subviewsByName')
        @removeSubview(name) for name,view of @.subviews

      if @.hasOwnProperty('unnamedSubviews')
        view.dispose() for view in @.unnamedSubviews

      @off()
      @remove()
      @undelegateEvents()

      # Finished.
      @disposed = true






  View
)