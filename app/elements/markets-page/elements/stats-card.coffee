'use strict'

Polymer 'stats-card',

  marketId: ''
  market: null
  priceUnit: null
  ticker: null

  ready: () ->
    @M = @msgMap[window.lang]

  tickerChanged: (o, n) ->
    @marketId = @ticker.c + "-" + @ticker.i;
    @market = window.config.markets[@marketId]
    if @market
      @priceUnit = @market.json.priceUnit

  formatChange: (value) ->
    percent = String(value * 100).substring(0, 5) + "%"
    if value > 0
      "+" + percent;
    else
      percent

  msgMap:
    'zh':
      lastPrice: "最新成交价"
      volume: "24小时总成交量"
      change: "24小时价格变化"

    'en':
      lastPrice: "Last Price"
      volume: "24H Volume"
      change: "24H Change"