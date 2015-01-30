'use strict'

Polymer 'market-page',
  msgMap:
    'en':
      trade: "Trade"
      trend: "Trend"
      orderBook: "Order Book"
      history: "Trade History"

    'zh':
      trade: "交易"
      trend: "趋势"
      orderBook: "深度"
      history: "历史成交"

  page: 0

  ready: () ->
    @M = @msgMap[window.lang]
    @buttons = [['trending-up', @M.trend],['swap-horiz', @M.trade],['list',@M.orderBook],['history', @M.history]]
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
