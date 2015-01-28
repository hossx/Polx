'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'kchart-subpage',
  msgMap:
    'en':
      priceChart: "Price Chart"
      buzz: "Buzz"

    'zh':
      priceChart: "价格图"
      buzz: "相关微博"

  ready: () ->
    @M = @msgMap[window.lang]

  active: false
  market: null
