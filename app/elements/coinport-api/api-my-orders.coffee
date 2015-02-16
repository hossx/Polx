'use strict'

Polymer 'api-my-orders',
  observe:
    marketId: 'onChange'
    cursor: 'onChange'
    limit: 'onChange'

  created: () ->
    @updateUrl()

  onChange: () ->
    @updateUrl()

  dataChanged: (o, n) ->
    if @data and @data.orders
      if not @marketId or @marketId == ''
        @orders = @data.orders
      else
        orders = []
        for order in @data.orders
          if order.market == @marketId
            orders.push order
          @orders = orders

  updateUrl: () ->
    base = window.config.api.base
    limit = if @limit > 0 then @limit else 50
    url = '%s/api/v2/user/orders?limit=%s'.format(base,limit)
    url = url + '%cursor=' + @cursor if @cursor > 0
    url = url + '&market=' + @marketId.toLowerCase() if @marketId
    @url = url