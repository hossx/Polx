'use strict'

# bids and asks are array of {price:price, quantity:quantity, accumulated:accumulated}
Polymer 'kchart-subpage',
  active: false
  market: null
  historyUrl: ''
  period: 3 # five minutes
  oneyear: 356*24*3600*1000

  activeChanged: (o, n) ->
    if @active and @market
      @historyUrl = window.protocol.historyUrl(@market.id, @period, 0)#Date.now()-@oneyear)

  marketChanged: (o, n) ->
    if @active and @market
      @historyUrl = window.protocol.historyUrl(@market.id, @period, 0)#Date.now()-@oneyear)

  responseChanged: (o, n) -> 
    if @response == ''
      @fire('network-error', {'url': @historyUrl})
    else if @response and @response.success
      @candles = @response.data.candles
      console.log(@historyUrl)
