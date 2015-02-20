'use strict'

Polymer 'api-market-tickers',
  currencyIdChanged: (o, n) ->
    if @currencyId
      @url = "%s/api/v2/%s/tickers".format(@base(), @currencyId.toLowerCase())

  dataChanged: (o, n) ->
    if @data
      @tickers = @data


