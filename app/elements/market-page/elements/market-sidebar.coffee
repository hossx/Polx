'use strict'

Polymer 'market-sidebar',
  msgMap:
    'en':
      markets: "Markets"

    'zh':
      markets: "市场"


  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    @marketGroupKeys = Object.keys(window.config.marketGroups)
    @marketId = ''
    @market = null
    @selectedGroup = ''
      
  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]
    if @market
      @selectedGroup = @market.baseCurrency.id