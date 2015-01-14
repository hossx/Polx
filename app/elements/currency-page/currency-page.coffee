'use strict'

Polymer 'currency-page',
  page: 0
  ready: () ->
    @buttons = [['info', "About"], ['verified-user', "Reserves"], ['cloud-download', 'Historical Data']]
    @currencyId = ''
    @currency = null
    @config = window.config


  currencyIdChanged: (o, n) ->
    @currency = @config.currencies[@currencyId]
    if not @currency
      console.warn("no such currency: " + @currencyId)
      # TODO: redirect to 404 page
    else
      @buttons[0][1] = "About " + @currency.name
      @buttons[1][1] = @currency.name + " Reserves"
      @buttons[2][1] = @currency.name + " Data"

  detached: () ->
    console.debug "detached: detached"