'use strict'

Polymer 'market-page',
   
  ready: () ->
    @buttons = [['swap-horiz', 'Trade'],['trending-up','Market Trend'],['list','Market Depth'],['history', 'History Data']]
    @marketId = ''
    @market = null
    @tab = 0
    @config = window.config

  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]
    if not @market
      console.warn("no such market: " + @marketId)
      # TODO: redirect to 404 page

  detached: () ->
    console.log "detached: detached"

  switchTabTo: (tab) -> @tab = tab
  switchTab0: () -> @switchTabTo(0)
  switchTab1: () -> @switchTabTo(1)
  switchTab2: () -> @switchTabTo(2)
  switchTab3: () -> @switchTabTo(3)
