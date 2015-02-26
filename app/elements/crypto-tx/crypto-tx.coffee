'use strict'

Polymer 'crypto-tx',
  currencyChanged: (o, n) ->
    if @currency and @tx and @currency.json.browser and @currency.json.browser.tx
      @link = @currency.json.browser.tx.format(@tx)

  formatTx: (tx) -> if tx then tx.substr(0, 10) + "..." else ''
