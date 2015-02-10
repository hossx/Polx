'use strict'

Polymer 'section-trade-history',
  msgMap:
    'en':
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      time: "Trade Time"

    'zh':
      price: "成交价"
      quantity: "成交量"
      total: "成交额"
      time: "时间"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")