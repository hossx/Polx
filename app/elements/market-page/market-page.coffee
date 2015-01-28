'use strict'

Polymer 'market-page',
  msgMap:
    'en':
      trade: "Trade"
      trend: "Trend"
      orderBook: "OrderBook"
      history: "History Data"

    'zh':
      trade: "交易"
      trend: "趋势"
      orderBook: "现有订单"
      history: "历史数据"

  page: 1

  ready: () ->
    @M = @msgMap[window.lang]
    @buttons = [['swap-horiz', @M.trade],['trending-up', @M.trend],['list',@M.orderBook],['history', @M.history]]
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
