'use strict'

# records are an array of {timestamp, isSell, price, quantity, total, typeClass, typeLabel}
Polymer 'trade-history-subpage',
  msgMap:
    'en':
      chart: "Taker Type Chart"
      tradeHistory: 'Trade History'
      index: "Index"
      takerOrderType: "Taker Order Type"
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      sell: "Sell"
      buy: "Buy"
      time: "Timestamp"
      id: "Trade ID"
      orderId: "Order ID"

    'zh':
      chart: "触发类型图"
      tradeHistory: '成交记录'
      index: "序号"
      takerOrderType: "触发单类型"
      price: "成交价"
      quantity: "成交量"
      total: "成交额"
      sell: "卖单"
      buy: "买单"
      time: "成交时间"
      id: "成交号"
      orderId: "订单号"


  ready: () ->
    @M = @msgMap[window.lang]

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")

  loadMore: () ->
    this.$.ajax.loadMore()