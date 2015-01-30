'use strict'

Polymer 'market-page2',
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
    @config = window.config
    
    @bids = []
    @asks = []
    @bidsReverse = []


  market: null
  orderBookUrl: ''

  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]
    if not @market
      console.warn("no such market: " + @marketId)
      # TODO: redirect to 404 page
    else
      size = 20 
      #window.config.viewParams.market.orderBookInitialSize
      @orderBookUrl = window.protocol.depthUrl(@market.id, size)

  orderBookRespChanged: (o, n) ->
    if @orderBookResp == ''
      @fire('network-error', {'url': @orderBookUrl})

    else if @orderBookResp and @orderBookResp.success
      asks = []
      bids = []

      accumulated = 0
      for a in @orderBookResp.data.a
        accumulated = accumulated + a.av
        asks.push {price: a.pv, quantity: a.av, accumulated: accumulated}
      
      accumulated = 0
      for b in @orderBookResp.data.b
        accumulated = accumulated + b.av
        bids.push {price: b.pv, quantity: b.av, accumulated: accumulated}

      @asks = asks
      @bids = bids
      @bidsReverse = bids.slice().reverse()
