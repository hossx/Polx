'use strict'

Polymer 'api-market-trade-history',
  hasMore: false
  loadingMore: false
  tailCursor: 0

  marketId: ''
  limit: 40
  cursor: 0

  observe:
    marketId: 'updateUrl'
    limit: 'updateUrl'
    cursor: 'updateUrl'
    
  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      for item in @data.trades
        item.class = if item.isSell then "sell" else "buy"
        item.total = item.amount * item.price

      if @loadingMore
        @loadingMore = false
        @trades.push @data.trades...
      else
        @trades = @data.trades

      len = @trades.length
      if len >= 1
        @tailCursor = @trades[len-1].id

  loadMore: () ->
    @loadingMore = true
    @cursor = @tailCursor


  updateUrl: () ->
    if @marketId
      limit = if @limit > 0 then @limit else 50
      url = "%s/api/v2/%s/trades?limit=%s".format(@base, @marketId.toLowerCase(), limit)
      url = url + "&cursor=" + @cursor if @cursor > 0
      @url = url
