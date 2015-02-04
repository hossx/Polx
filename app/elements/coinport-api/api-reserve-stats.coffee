'use strict'

Polymer 'api-reserve-stats',
  created: () ->
    @url = window.protocol.reserveStatsUrl()

  dataChanged: (o, n) ->
    if @data
      @reserveStats = @data

