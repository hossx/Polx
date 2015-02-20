'use strict'

Polymer 'api-market-trade-history',
  marketId: ''
  limit: 50
  cursor: 0

  trades: []
  hasMore: false

  observe:
    marketId: 'onChange'
    limit: 'onChange'
    cursor: 'onChange'
    
  onChange: (o, n) ->
    if @marketId
      limit = if @limit > 0 then @limit else 50
      url = "%s/api/v2/%s/trades?limit=%s".format(@base, @marketId.toLowerCase(), limit)
      url = url + "&cursor=" + @cursor if @cursor > 0
      @url = url

  dataChanged: (o, n) ->
    if @data
      for item in @data.trades
        item.class = if item.isSell then "sell" else "buy"
        item.total = item.amount * item.price
      @trades = @data.trades
      @hasMore = @data.hasMore

  loadMore: () ->
    console.log("TODO")