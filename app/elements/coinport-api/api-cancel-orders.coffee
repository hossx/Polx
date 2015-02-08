'use strict'

Polymer 'api-cancel-orders',
  orderIds: []

  orderIdsChanged: (o, n) ->
    if @orderIds and @orderIds.length > 0
      @method = 'POST'
      @contentType = 'text/json'
      @body ='{"order_ids": [%s]}'.format(@orderIds.join(','))
      console.log(@body)
      @url = window.protocol.userCancelOrders()

  dataChanged: (o, n) ->
    if @data
      console.log(@data)
      @cancelledIds = @data.cancelled
      @failedIds = @data.failed