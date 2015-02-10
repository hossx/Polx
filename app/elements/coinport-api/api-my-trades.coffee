'use strict'

Polymer 'api-my-trades',
  marketId: null
  cursor: 0
  limit: 50
  trades: []

  observe:
    marketId: 'onChange'
    cursor: 'onChange'
    limit: 'onChange'

  onChange: () ->
    if @marketId
      @url = window.protocol.userTradesUrl(@marketId,@cursor,@limit)

  dataChanged: (o, n) ->
    if @data and @data.trades
      for item in @data.trades
        item.class = if item.isSell then "sell" else "buy"
        item.total = item.amount * item.price

      @hasMore = @data.hasMore
      @trades = @data.trades
