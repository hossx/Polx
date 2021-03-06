'use strict'

Polymer 'market-page',
  page: 0

  ready: () ->
    @M = window.M['market']['market']
    @buttons = [['trending-up', @M.trend],['list',@M.orderBook],['history', @M.history]]
    @marketId = ''
    @market = null
    @config = window.config

  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]
    if not @market
      console.warn("no such market: " + @marketId)
      # TODO: redirect to 404 page

  detached: () ->
    console.log "detached: detached"
