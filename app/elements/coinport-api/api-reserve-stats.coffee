Polymer 'api-reserve-stats',
  ready: () ->
    `this.super()`
    @url = window.protocol.reserveStatsUrl()

  dataChanged: (o, n) ->
    if @data
      @reserveStats = @data

