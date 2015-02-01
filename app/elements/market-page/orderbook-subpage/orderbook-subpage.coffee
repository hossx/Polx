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
      accumulated: "累积数量"

  ready: () ->
    @M = @msgMap[window.lang]

  active: false

  observe:
    active: 'onChange'
    market: 'onChange'

  onChange: () ->
    if @active and @market
      this.$.ajax.go()
