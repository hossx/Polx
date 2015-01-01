'use strict'

Polymer 'details-subpage',
  ready: () ->
    @url = window.protocol.currencyDetailsUrl(@currency)
    console.log(@detailsUrl)