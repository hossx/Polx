'use strict'

Polymer 'crypto-address',
  msgMap:
    'en':
      checkout: "Check out this address at:"
    'zh':
      checkout: "查看该地址："

  link: null

  ready: () ->
    @M = @msgMap[window.lang]

  currencyChanged: (o, n) ->
    if @currency
      if @addr and @currency.json.browser and @currency.json.browser.addr
        @link = @currency.json.browser.addr.format(@addr)
