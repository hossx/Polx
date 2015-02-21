'use strict'

Polymer 'api-my-deposit-addresses',
  addressMap: {}

  created: () ->
    @url = '%s/api/v2/user/deposit_addresses'.format(@base())

   dataChanged: (o, n) ->
    if @data
      @addressMap = @data
     

