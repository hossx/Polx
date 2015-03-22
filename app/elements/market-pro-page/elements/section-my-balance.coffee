'use strict'

Polymer 'section-my-balance',
  ready: () ->
    @M = window.M['market-pro']['my-balance']

  go: () ->
    this.$.ajax.go()

  balanceMapChanged: (o, n) ->
    @balance = if @balanceMap[@market.currency.id] then @balanceMap[@market.currency.id][0] else 0
    @baseBalance = if @balanceMap[@market.baseCurrency.id] then @balanceMap[@market.baseCurrency.id][0] else 0

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")