'use strict'

Polymer 'section-my-orders',
  msgMap:
    'en':
      type: "Type"
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      time: "Creation Time"
      buy: "Buy"
      sell: "Sell"

    'zh':
      type: "类型"
      price: "价格"
      quantity: "数量"
      total: "总金额"
      time: "下单时间"
      buy: "买入"
      sell: "卖出"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(@value).format("MM/DD-HH:mm")