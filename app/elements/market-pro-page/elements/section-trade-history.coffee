'use strict'

Polymer 'section-trade-history',
  msgMap:
    'en':
      price: "Price"
      quantity: "Quantity"
      time: "Trade Time"

    'zh':
      price: "价格"
      quantity: "数量"
      time: "成交时间"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(@value).format("MM/DD-HH:mm")