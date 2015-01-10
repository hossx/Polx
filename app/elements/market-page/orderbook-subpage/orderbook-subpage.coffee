'use strict'

Polymer 'orderbook-subpage',
  active: false
  market: null
  depthUrl: ''

  created: () ->
    
  activeChanged: (o, n) ->
    console.log(@active)
    if @active and @market
      @depthUrl = window.protocol.depthUrl(@market.id)

  marketChanged: (o, n) ->
    if @active and @market
      @depthUrl = window.protocol.depthUrl(@market.id)

  responseChanged: (o, n) ->
    console.log(@response)