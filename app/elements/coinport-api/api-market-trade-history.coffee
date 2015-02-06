'use strict'

Polymer 'api-market-trade-history',
  limit: 50
  trades: []
  hasMore: false

  observe:
    limit: 'onChange'
    marketId: 'onChange'

  created: () ->
    @limit = window.config.viewParams.market.tradingRecordInitialSize

  onChange: (o, n) ->
    @url = window.protocol.tradeHistoryUrl(@marketId, @limit)

  dataChanged: (o, n) ->
    if @data
      for item in @data.trades
        item.class = if item.isSell then "sell" else "buy"
        item.timestamp = moment(item.timestamp).format("hh:mm:ss")
        item.total = item.amount * item.price
      @trades = @data.trades
      @hasMore = @data.hasMore
