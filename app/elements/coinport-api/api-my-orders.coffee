'use strict'

Polymer 'api-my-orders',
  orders: []
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
    base = window.config.api.base
    limit = if @limit > 0 then @limit else 50
    url = '%s/api/v2/user/orders?limit=%s'.format(base,limit)
    url = url + '%cursor=' + @cursor if @cursor > 0
    url = url + '&market=' + @marketId.toLowerCase() if @marketId
    @url = url