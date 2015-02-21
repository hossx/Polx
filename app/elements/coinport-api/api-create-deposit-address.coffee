'use strict'

Polymer 'api-create-deposit-address',
  createAddress: (currencyId) ->
      @headers['Content-Type'] = 'application/json' if @headers
      @contentType = 'application/json'
      @method = 'POST'
      @url = "%s/api/v2/user/create_deposit_addr/%s".format(@base(), currencyId)
      @body = '{}'
      @go()

  dataChanged: (o, n) ->
    if @data
      console.log(@data)
      
