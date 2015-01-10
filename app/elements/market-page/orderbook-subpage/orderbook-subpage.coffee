'use strict'

Polymer 'orderbook-subpage',
  active: false
  market: null
  depthUrl: ''

  created: () ->
    @bids = []
    @asks = []
    
  activeChanged: (o, n) ->
    if @active and @market
      @depthUrl = window.protocol.depthUrl(@market.id, 40)

  marketChanged: (o, n) ->
    if @active and @market
      @depthUrl = window.protocol.depthUrl(@market.id, 40)

  responseChanged: (o, n) ->
    if @response == ''
      @fire('network-error', {'url': @depthUrl})
    else if @response and @response.success
      asks = []
      bids = []

      accumulated = 0
      for a in @response.data.a
        accumulated = accumulated + a.av
        asks.push {price: a.pv, quantity: a.av, accumulated: accumulated}
      @asks = asks

      accumulated = 0
      for b in @response.data.b
        accumulated = accumulated + b.av
        bids.push {price: b.pv, quantity: b.av, accumulated: accumulated}
      @bids = bids
