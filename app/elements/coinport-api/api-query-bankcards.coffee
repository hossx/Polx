'use strict'

Polymer 'api-query-bankcards',
  created: () ->
    @updateUrl()

  dataChanged: (o, n) ->
    @cards = @data if @data

  updateUrl: () ->
    @url = "%s/api/v2/user/query_bankcards".format(@base())
