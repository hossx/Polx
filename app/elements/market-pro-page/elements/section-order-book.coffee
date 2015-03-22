'use strict'

Polymer 'section-order-book',
  ready: () ->
    @M = window.M['market-pro']['orderbook']

  buyClicked: (e, detail, sender)->
   @fire('buy-clicked', {buy: e.target.templateInstance.model.bid})

  sellClicked: (e, detail, sender)->
   @fire('sell-clicked', {sell: e.target.templateInstance.model.ask})

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")