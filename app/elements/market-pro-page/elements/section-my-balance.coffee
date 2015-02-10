'use strict'

Polymer 'section-my-balance',
  msgMap:
    'en':
      withdraw: "Withdraw"
      deposit: "Deposit"

    'zh':
      withdraw: "提现"
      deposit: "充值"

  ready: () ->
    @M = @msgMap[window.lang]

  go: () ->
    this.$.ajax.go()

  balanceMapChanged: (o, n) ->
    @balance = if @balanceMap[@market.currency.id] then @balanceMap[@market.currency.id][0] else 0
    @baseBalance = if @balanceMap[@market.baseCurrency.id] then @balanceMap[@market.baseCurrency.id][0] else 0

  formatTime: (t) ->
    moment(@value).format("MM/DD-HH:mm")