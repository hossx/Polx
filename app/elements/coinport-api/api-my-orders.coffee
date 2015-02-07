Polymer 'api-my-orders',

  ready: () ->
    `this.super()`
    @url = window.protocol.userOrdersUrl()

  dataChanged: (o, n) ->
    if @data and @data.orders
      @orders = @data.orders

