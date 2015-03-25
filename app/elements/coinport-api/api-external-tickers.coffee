'use strict'

Polymer 'api-external-tickers',
  
  created: () ->
    @url = "%s/api/v2/BTC/external_tickers".format(@base())

  dataChanged: (o, n) ->
    if @data and @data['BTC-CNY']
      raw = 
      @tickers = []

      for k, v of @data['BTC-CNY']
        @tickers.push {
          id: k
          name: window.config.externalMarkets[k].name
          data: v
        }
