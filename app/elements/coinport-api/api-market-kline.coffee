'use strict'

Polymer 'api-market-kline',
  interval: '1d'
  start: 0
  end: -1
  candles: []

    
  observe:
    marketId: 'onChange'
    interval: 'onChange'
    start: 'onChange'
    end: 'onChange'

  onChange: (o, n) ->
    if @interval and @marketId
      start = if @start > 0 then @start else 0
      url = '%s/api/v2/%s/kline?interval=%s&start=%s'.format(@base(), @marketId.toLowerCase(), @interval, start)
      url = url + "&end=" + @end if @end > start
      @url = url

  dataChanged: (o, n) ->
    if @data and @data.items
      @candles = @data.items
