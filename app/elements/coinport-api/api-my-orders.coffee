'use strict'

Polymer 'api-my-orders',
  marketId: null
  cursor: 0
  limit: 50
  orders: []

  observe:
    marketId: 'onChange'
    cursor: 'onChange'
    limit: 'onChange'

  onChange: () ->
    if @marketId
      @url = window.protocol.userOrdersUrl(@marketId,@cursor,@limit)

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
