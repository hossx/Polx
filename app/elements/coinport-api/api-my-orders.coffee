'use strict'

Polymer 'api-my-orders',
  hasMore: false
  orders: []

  marketId: ''
  limit: 40
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
      if not @marketId or @marketId == ''
        @orders = @data.orders
      else
        orders = []
        for order in @data.orders
          if order.market == @marketId
            orders.push order
          @orders = orders

  loadMore: () ->
    console.log("load more......")

  updateUrl: () ->
    limit = if @limit > 0 then @limit else 50
    url = '%s/api/v2/user/orders?limit=%s'.format(@base(),limit)
    url = url + '&cursor=' + @cursor if @cursor > 0
    url = url + '&market=' + @marketId.toLowerCase() if @marketId
    @url = url