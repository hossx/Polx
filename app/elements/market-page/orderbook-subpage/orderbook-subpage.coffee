'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'orderbook-subpage',
  msgMap:
    'en':
      depthChart: "Depth Chart"
      orderBook: "Order Book"
      buyOrders: "Buy Orders"
      sellOrders: "Sell Orders"
      index: "Index"
      price: "Price"
      quantity: "Quantity"
      accumulated: "Accumulated"

    'zh':
      depthChart: "深度图"
      orderBook: "现有订单"
      buyOrders: "买单"
      sellOrders: "卖单"
      index: "排序"
      price: "价格"
      quantity: "数量"
      accumulated: "累计数量"

  ready: () ->
    @M = @msgMap[window.lang]

  active: false
  market: null
  depthUrl: ''

  created: () ->
    @size = window.config.viewParams.market.orderBookInitialSize
    @bids = []
    @asks = []
    
  activeChanged: (o, n) ->
    if @active and @market
      @depthUrl = window.protocol.depthUrl(@market.id, @size)

  marketChanged: (o, n) ->
    if @active and @market
      @depthUrl = window.protocol.depthUrl(@market.id, @size)

  responseChanged: (o, n) ->
    if @response == ''
      @fire('network-error', {'url': @depthUrl})
    else if @response and @response.success
      asks = []
      bids = []

      accumulated = 0
      for a in @response.data.a
        accumulated = accumulated + a.av
        asks.push {price: a.pv, quantity: a.av, accumulated: accumulated}
      
      accumulated = 0
      for b in @response.data.b
        accumulated = accumulated + b.av
        bids.push {price: b.pv, quantity: b.av, accumulated: accumulated}

      setTimeout () =>
        @asks = asks
        @bids = bids
      , 400
