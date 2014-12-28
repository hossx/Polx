'use strict'

Polymer
  ready: () ->
    @tickerUrl = window.protocol.tickerUrl(@currency.id)
    @tickers = []

  responseChanged: (o, n) ->
    @tickers = n.data