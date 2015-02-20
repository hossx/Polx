'use strict'

Polymer 'api-my-balance',
  created: () ->
    @url = '%s/api/v2/user/balance'.format(@base())

  dataChanged: (o, n) ->
    @balance = @data if @data
    