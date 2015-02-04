'use strict'

Polymer 'api-currency-reserves',
  currencyIdChanged: () ->
    if @currencyId
      @url = window.protocol.reserveDetailsUrl(@currencyId)

  dataChanged: (o, n) ->
    if @data
      @stats = @data.stats
      @distribution = @data.distribution

