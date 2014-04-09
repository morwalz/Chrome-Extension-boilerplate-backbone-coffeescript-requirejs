define(['jquery',
        'Underscore',
        'Backbone'], ($,_,Backbone) ->

  class Collection extends Backbone.Collection

    trigger: (event, args...) =>
      super
      thisType = @__proto__?.constructor?.name
      console.log "[E][C][#{thisType}]:\t #{event}"  if OH?.verbose?.match /vvvv/i

  Collection
)