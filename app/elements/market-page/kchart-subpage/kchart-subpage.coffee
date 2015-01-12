'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'kchart-subpage',
  active: false
  market: null
  historyUrl: ''
  period: 3 # five minutes

  activeChanged: (o, n) ->
    if @active and @market
      @historyUrl = window.protocol.historyUrl(@market.id, @period)

  marketChanged: (o, n) ->
    if @active and @market
      @historyUrl = window.protocol.historyUrl(@market.id, @period)

  responseChanged: (o, n) -> 
    if @response == ''
      @fire('network-error', {'url': @historyUrl})
    else if @response and @response.success
      @candles = @response.data.candles
