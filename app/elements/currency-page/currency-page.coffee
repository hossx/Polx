'use strict'

Polymer 'currency-page',
   
  ready: () ->
    @buttons = [['info', "Reserve Details"], ['cloud-download', 'History Data']]
    @currencyId = ''
    @currency = null
    @tab = 0
    @config = window.config


  currencyIdChanged: (o, n) ->
    @currency = @config.currencies[@currencyId]
    if not @currency
      console.warn("no such currency: " + @currencyId)
      # TODO: redirect to 404 page

  detached: () ->
    console.debug "detached: detached"

  switchTabTo: (tab) -> @tab = tab
  switchTab0: () -> @switchTabTo(0)
  switchTab1: () -> @switchTabTo(1)
