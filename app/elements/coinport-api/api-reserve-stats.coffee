'use strict'

Polymer 'api-reserve-stats',
  created: () ->
    @url = '%s/api/v2/reserve_stats'.format(@base())

  dataChanged: (o, n) ->
    if @data
      @reserveStats = @data

