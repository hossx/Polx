'use strict'

Polymer 'currency-page',
  page: 0
  ready: () ->
    @buttons = [['info', "Reserve Details"], ['cloud-download', 'History Data']]
    @currencyId = ''
    @currency = null
    @config = window.config


  currencyIdChanged: (o, n) ->
    @currency = @config.currencies[@currencyId]
    if not @currency
      console.warn("no such currency: " + @currencyId)
      # TODO: redirect to 404 page

  detached: () ->
    console.debug "detached: detached"