'use strict'

Polymer 'api-cancel-orders',

  cancelOrder: (orderId) ->
      @headers['Content-Type'] = 'application/json'  if @headers
      @contentType = 'application/json'
      @method = 'POST'
      @body ='{"order_ids": [%s]}'.format(orderId)
      @url = '%s/api/v2/user/cancel_orders'.format(@base())
      @go()

  dataChanged: (o, n) ->
    if @data
      @cancelledIds = @data.cancelled
      @failedIds = @data.failed