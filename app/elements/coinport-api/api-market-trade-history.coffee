'use strict'

Polymer 'api-market-trade-history',
  limit: 50
  trades: []
  hasMore: false

  observe:
    limit: 'onChange'
    marketId: 'onChange'
    
  onChange: (o, n) ->
    @url = window.protocol.marketTradesUrl(@marketId, @limit)

  dataChanged: (o, n) ->
    if @data
      for item in @data.trades
        item.class = if item.isSell then "sell" else "buy"
        item.total = item.amount * item.price
      @trades = @data.trades
      @hasMore = @data.hasMore
