Polymer 'api-my-profile',
  
  ready: () ->
    `this.super()`
    @url = window.protocol.userProfileUrl()

  dataChanged: (o, n) ->
    @profile = @data if @data
