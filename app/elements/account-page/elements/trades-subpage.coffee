'use strict'

Polymer 'trades-subpage',
  msgMap:
    'en':
      trades: "Trades"
      id: "ID"
      market: "Market"
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      time: "Time"
      type: "Type"
      types:
        buy: "Buy"
        sell: "Sell"

    'zh':
      trades: "成交记录"
      id: "ID"
      market: "市场"
      price: "成交价"
      quantity: "成交量"
      total: "成交额"
      time: "成交时间"
      type: "类型"
      types:
        buy: "买入"
        sell: "卖出"

  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config

  formatTime: (t) ->
    moment(t).format("YYYY-MM/DD-hh:mm") 
