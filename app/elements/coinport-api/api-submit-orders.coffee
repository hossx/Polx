'use strict'

Polymer 'api-submit-orders',
  submitOrder: (order) ->
      @headers['Content-Type'] = 'application/json' if @headers
      @contentType = 'application/json'
      @method = 'POST'
      @url = '%s/api/v2/user/submit_orders'.format(@base())
      @body = '{"orders": [%s]}'.format(order)
      console.log(@body)
      @go()

  dataChanged: (o, n) ->
    if @data
      @results = @data.results
