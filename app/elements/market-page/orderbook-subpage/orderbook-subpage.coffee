'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'orderbook-subpage',
  ready: () ->
    @M = window.M['market']['orderbook']