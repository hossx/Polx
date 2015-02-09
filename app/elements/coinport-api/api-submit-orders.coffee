'use strict'

Polymer 'api-submit-orders',
  submitOrder: (order) ->
      @headers['Content-Type'] = 'application/json' if @headers
      @contentType = 'application/json'
      @method = 'POST'
      @url = window.protocol.userSubmitOrdersUrl()
      @body = '{"orders": [%s]}'.format(order)
      console.log(@body)
      @go()

  dataChanged: (o, n) ->
    if @data
      @results = @data.results
