'use strict'

Polymer 'stats-card',

  ready: () ->
    @config = window.config
    @marketId = ''
    @market = ''
    @ticker = null
    @priceUnit = ''

  tickerChanged: (o, n) ->
    @marketId = @ticker.c + "-" + @ticker.i;
    @market = @config.markets[@marketId]
    if @market
      @priceUnit = @market.json.priceUnit

  # Filters
  formatChange: (value) ->
    percent = String(value * 100).substring(0, 5) + "%"
    if value > 0
      "+" + percent;
    else
      percent
