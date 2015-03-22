'use strict'

Polymer 'section-my-trades',
  ready: () ->
    @M = window.M['market-pro']['my-trades']

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")

  formatLabel: (trade) ->
    if trade.isSell then @M.sell else @M.buy

  extractOrderId: (id) ->
    len = id.length
    id.substring(0, len-3)

  extractTradeIndex: (id) ->
    len = id.length
    id.substring(len-3)
