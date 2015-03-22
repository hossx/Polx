'use strict'

Polymer 'crypto-address',
  link: null

  ready: () ->
    @M = window.M['utils']['crypto-address']

  currencyChanged: (o, n) ->
    if @currency
      if @addr and @currency.json.browser and @currency.json.browser.addr
        @link = @currency.json.browser.addr.format(@addr)
