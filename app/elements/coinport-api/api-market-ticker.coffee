'use strict'

Polymer 'api-market-ticker',
  ticker: null

  marketIdChanged: (o, n) ->
    if @marketId
      @url = "%s/api/v2/%s/ticker".format(@base(), @marketId.toLowerCase())

  dataChanged: (o, n) ->
    if @data and @data[@marketId]
      raw = @data[@marketId]
      @ticker =
        price:raw[0]
        low: raw[1]
        high: raw[2]
        volume: raw[3]
        change: raw[4]
        changeTxt: if raw[4] < 0 then (100*raw[4]).toFixed(2)+"%" else "+" + (100*raw[4]).toFixed(2)+"%"
        changeType:
          if raw[4] < 0
            "down"
          else if raw[4] > 0
            "up"
          else
            @changeClass = ''


