'use strict'

Polymer 'api-currency-reserves',

  currencyIdChanged: () ->
    if @currencyId
      @url = '%s/api/v2/%s/reserves'.format(@base(), @currencyId.toLowerCase())

  dataChanged: (o, n) ->
    if @data
      @stats = @data.stats
      @distribution = @data.distribution

