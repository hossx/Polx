'use strict'

Polymer 'stats-card',

  marketId: ''
  market: null
  priceUnit: null
  ticker: null

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
