'use strict'

Polymer 'api-currency-reserves',
  created: () ->
    @url = window.protocol.reserveStatsUrl()

  dataChanged: (o, n) ->
    if @data
      @reserveStats = @data

