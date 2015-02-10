'use strict'

Polymer 'section-my-trades',
  msgMap:
    'en':
      id: "ID"
      orderId: "Order ID"
      type: "Type"
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      time: "Timestamp"
      buy: "Buy"
      sell: "Sell"


    'zh':
      id: "交易号"
      orderId: "订单号"
      type: "类型"
      price: "成交价"
      quantity: "成交量"
      total: "成交额"
      time: "时间"
      buy: "买入"
      sell: "卖出"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")

  formatLabel: (trade) ->
    if trade.isSell then @M.sell else @M.buy
