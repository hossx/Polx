Polymer 'api-my-profile',
  
  ready: () ->
    `this.super()`
    @url = window.protocol.userProfileUrl()
    console.log(@url)

  dataChanged: (o, n) ->
    @profile = @data if @data
    console.log(@profile)
