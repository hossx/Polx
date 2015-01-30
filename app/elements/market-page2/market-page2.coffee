'use strict'

Polymer 'market-page2',
  ready: () ->
    @config = window.config


 marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]
    if not @market
      console.warn("no such market: " + @marketId)
      # TODO: redirect to 404 page