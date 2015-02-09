'use strict'

Polymer 'section-order-book',
  msgMap:
    'en':
      buy: "Buy"
      sell: "Sell"
      price: "Price"
      quantity: "Quantity"
      accumulated: "Accumulated"
      spread: "Spread"

    'zh':
      buy: "买"
      sell: "卖"
      price: "价格"
      quantity: "数量"
      accumulated: "累积数量"
      spread: "买卖价差"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(@value).format("MM/DD-HH:mm")