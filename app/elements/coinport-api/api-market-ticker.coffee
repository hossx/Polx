'use strict'

Polymer 'api-market-ticker',
  
  ticker: null

  marketIdChanged: (o, n) ->
    @url = window.protocol.tickerUrl(@marketId)

  dataChanged: (o, n) ->
    if @data and @data[@marketId]
      raw = @data[@marketId]
      @ticker =
        price:raw[0]
        low: raw[1]
        high: raw[2]
        volume: raw[3]
        change: raw[4]
        changeTxt: (100*raw[4]).toFixed(2)+"%"
        changeType:
          if raw[4] < 0
            "down"
          else if raw[4] > 0
            "up"
          else
            @changeClass = ''

