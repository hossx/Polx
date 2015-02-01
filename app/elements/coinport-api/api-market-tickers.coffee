'use strict'

Polymer 'api-market-tickers',

  currencyIdChanged: (o, n) ->
    if @currencyId
      @url = window.protocol.tickersUrl(@currencyId)

  dataChanged: (o, n) ->
    if @data
      @tickers = @data


