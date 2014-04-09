define(['jquery'
        'Underscore'
        'Backbone'
        ], ($, _, Backbone) ->

  class ChromeExtension
    browserAction = window.chrome.browserAction
    runTime = window.chrome.runtime
    chromeExtension = window.chrome.extension
    getBackgroundOfficeInstance: ->
      chromeExtension.getBackgroundPage().Office

    popUpRunning: (status = null)->
      chromeExtension.getBackgroundPage().Office.popUpRunning(status)




  new ChromeExtension
)