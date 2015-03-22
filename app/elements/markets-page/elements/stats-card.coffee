'use strict'

Polymer 'stats-card',
  marketId: ''
  ticker: null

  ready: () ->
    @M = window.M['markets']['card']

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
