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

  formatTime: (t) ->
    moment(@value).format("MM/DD-HH:mm")