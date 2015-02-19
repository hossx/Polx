'use strict'

Polymer 'api-my-trades',
  trades: []
  hasMore: false

  observe:
    marketId: 'onChange'
    limit: 'onChange'
    cursor: 'onChange'

  created: () ->
    @updateUrl()

  onChange: () ->
    @updateUrl()

  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      for item in @data.trades
        item.class = if item.isSell then "sell" else "buy"
        item.total = item.amount * item.price

      @hasMore = @data.hasMore
      @trades = @data.trades

  loadMore: () ->
    console.log("load more...")

  updateUrl: () ->
    base = window.config.api.base
    limit = if @limit > 0 then @limit else 50
    url = '%s/api/v2/user/trades?limit=%s'.format(base,limit)
    url = url + '%cursor=' + @cursor if @cursor > 0
    url = url + '&market=' + @marketId.toLowerCase() if @marketId
    @url = url
      