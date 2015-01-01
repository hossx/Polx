'use strict'

Polymer 'details-subpage',
  wiki: ''
  details: null

  ready: () ->
    @detailsUrl = window.protocol.currencyDetailsUrl(@currency)

  detailsChanged: (o, n) ->
