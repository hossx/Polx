'use strict'

Polymer 'api-my-orders',

  created: () ->
    @url = window.protocol.userOrdersUrl()

  dataChanged: (o, n) ->
    if @data and @data.orders
      @orders = @data.orders

