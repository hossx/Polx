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

    'zh':
      chart: "触发类型图"
      tradeHistory: '成交记录'
      index: "序号"
      takerOrderType: "触发单类型"
      price: "价格"
      quantity: "数量"
      total: "成交额"
      sell: "卖单"
      buy: "买单"


  ready: () ->
    @M = @msgMap[window.lang]
