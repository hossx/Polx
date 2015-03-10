'use strict'

Polymer 'api-my-orders',
  hasMore: false
  loadingMore: false
  orders: []

  marketId: ''
  limit: 0
  cursor: 0

  observe:
    marketId: 'onChange'
    limit: 'onChange'
    cursor: 'onChange'

  onChange: () ->
    @updateUrl()

  dataChanged: (o, n) ->
    if @data
      @hasMore = @data.hasMore
      if @loadingMore
        @loadingMore = false
        @orders.push @data.orders...
      else
        @orders = @data.orders

      len = @orders.length
      if len >= 1
        @tailCursor = @orders[len-1].id
        console.log(@tailCursor) 

  loadMore: () ->
    @loadingMore = true
    @cursor = @tailCursor

  updateUrl: () ->
    limit = if @limit > 0 then @limit else 50
    url = '%s/api/v2/user/orders?limit=%s'.format(@base(),limit)
    url = url + '&cursor=' + @cursor if @cursor > 0
    url = url + '&market=' + @marketId.toLowerCase() if @marketId
    @url = url