'use strict'

Polymer 'market-sidebar-item',
  altview: false
  market: null
  target: ''

  observe: {
    market: 'updateLink'
    altview: 'updateLink'
  }

  updateLink: ()->
    if @market
      @target = 
        if @altview
          "/#/marketpro/" + @market.id
        else
          "/#/market/" + @market.id
