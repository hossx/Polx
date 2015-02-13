Polymer 'api-reserve-stats',
  ready: () ->
    `this.super()`
    @url = window.protocol.currenciesReserveStatsUrl()

  dataChanged: (o, n) ->
    if @data
      @reserveStats = @data

