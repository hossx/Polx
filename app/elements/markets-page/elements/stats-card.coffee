'use strict'

Polymer 'stats-card',
  msgMap:
    'zh':
      lastPrice: "最新成交价"
      volume: "24小时总成交量"
      change: "24小时价格变化"

    'en':
      lastPrice: "Last Price"
      volume: "24H Volume"
      change: "24H Change"

  marketId: ''
  ticker: null

  ready: () ->
    @M = @msgMap[window.lang]

  marketIdChanged: (o, n) ->
    @market = window.config.markets[@marketId]

  tickerChanged: (o, n) ->
    @changeClass =
      if @ticker[4] > 0
        "up"
      else if @ticker[4] < 0
        "down"
      else
        ""
  formatChange: (value) ->
    percent = (value * 100).toFixed(2) + "%"
    if value > 0
      "+" + percent;
    else
      percent

  formatVolume: (v) ->
    v.toFixed(4)
