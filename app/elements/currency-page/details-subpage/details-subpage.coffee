'use strict'

Polymer 'details-subpage',
  wiki: ''
  details: null
  detailsUrl: ''

  currencyChanged: () ->
    @detailsUrl = window.protocol.reserveDetailsUrl(@currency.id)

  detailsChanged: (o, n) ->
