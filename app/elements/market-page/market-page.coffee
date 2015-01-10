'use strict'

Polymer 'market-page',
  page: 0

  ready: () ->
    @buttons = [['swap-horiz', 'Trade'],['trending-up','Market Trend'],['list','Orderbook'],['history', 'History Data']]
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
