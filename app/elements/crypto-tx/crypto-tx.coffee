'use strict'

Polymer 'crypto-tx',
  msgMap:
    'en':
      checkout: "Check out this transaction at:"
    'zh':
      checkout: "查看该交易："

  link: null

  ready: () ->
    @M = @msgMap[window.lang]

  currencyChanged: (o, n) ->
    if @currency and @tx and @currency.json.browser and @currency.json.browser.tx
      @link = @currency.json.browser.tx.format(@tx)

  formatTx: (tx) -> if tx then tx.substr(0, 20) + "..." else ''
