'use strict'

Polymer 'section-my-orders',
  msgMap:
    'en':
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      time: "Creation Time"

    'zh':
      price: "价格"
      quantity: "数量"
      total: "总金额"
      time: "下单时间"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(@value).format("MM/DD-HH:mm")