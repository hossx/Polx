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
          "/#/market2/" + @market.id
        else
          "/#/market/" + @market.id
