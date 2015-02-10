Polymer 'api-my-balance',
  
  ready: () ->
    `this.super()`
    @url = window.protocol.userBalanceUrl()

  dataChanged: (o, n) ->
    @balance = @data if @data
