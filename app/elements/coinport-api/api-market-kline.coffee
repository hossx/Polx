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
      end = if @end <=0 then Date.now() else @end
      @url = window.protocol.marketKlineUrl(@marketId, @interval, @start, end)

  dataChanged: (o, n) ->
    if @data and @data.items
      @candles = @data.items
