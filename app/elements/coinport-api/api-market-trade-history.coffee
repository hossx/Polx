'use strict'

Polymer 'api-market-trade-history',
  limit: 50
  trades: []
  hasMore: false

  observe:
    limit: 'onChange'
    marketId: 'onChange'

  onChange: (o, n) ->
    @url = window.protocol.tradeHistoryUrl(@marketId, @limit)

  dataChanged: (o, n) ->
    if @data
      @trades = ({
        timestamp: moment(item.timestamp).format("hh:mm:ss")
        class: if item.isSell then "sell" else "buy"
        price: item.price
        quantity: item.amount
        total: item.amount * item.price} for item in @data.trades)
      @hasMore = @data.hasMore
