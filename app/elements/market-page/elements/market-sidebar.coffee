'use strict'

Polymer 'market-sidebar',
  ready: ()-> 
    @config = window.config
    @marketGroupKeys = Object.keys(window.config.marketGroups)
    @marketId = ''
    @market = null
    @selectedGroup = ''
      
  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]
    if @market
      @selectedGroup = @market.baseCurrency.id