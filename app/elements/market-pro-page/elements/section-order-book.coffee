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

  buyClicked: (e, detail, sender)->
   @fire('buy-clicked', {buy: e.target.templateInstance.model.bid})

  sellClicked: (e, detail, sender)->
   @fire('sell-clicked', {sell: e.target.templateInstance.model.ask})

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")