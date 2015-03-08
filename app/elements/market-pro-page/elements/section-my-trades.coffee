'use strict'

Polymer 'section-my-trades',
  msgMap:
    'en':
      id: "Trade ID"
      orderId: "Order ID"
      type: "Type"
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      time: "Timestamp"
      buy: "Buy"
      sell: "Sell"
      noTrades: "No Trades"


    'zh':
      id: "成交号"
      orderId: "订单号"
      type: "类型"
      price: "成交价"
      quantity: "成交量"
      total: "成交额"
      time: "时间"
      buy: "买入"
      sell: "卖出"
      noTrades: "没有成交记录"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")

  formatLabel: (trade) ->
    if trade.isSell then @M.sell else @M.buy

  extractOrderId: (id) ->
    len = id.length
    id.substring(0, len-3)

  extractTradeIndex: (id) ->
    len = id.length
    id.substring(len-3)
