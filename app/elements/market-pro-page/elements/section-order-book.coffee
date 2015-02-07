'use strict'

Polymer 'section-order-book',
  msgMap:
    'en':
      price: "Price"
      quantity: "Quantity"
      accumulated: "Accumulated"
      spread: "Spread"

    'zh':
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