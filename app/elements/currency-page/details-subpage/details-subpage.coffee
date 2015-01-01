'use strict'

Polymer 'details-subpage',
  wiki: ''
  details: null
  detailsUrl: ''

  currencyChanged: () ->
    @detailsUrl = window.protocol.currencyDetailsUrl(@currency.id)

  detailsChanged: (o, n) ->
