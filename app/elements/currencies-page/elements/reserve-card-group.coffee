'use strict'

Polymer 'reserve-card-group',
  msgMap:
    'en':
      reserveStats: "Currency Reserves"

    'zh':
      reserveStats: "货币准备金"

  ready: () ->
    @M = @msgMap[window.lang]

  reserveStatsChanged: (o, n) ->
    if @reserveStats
      @currencieIds = Object.keys(@reserveStats).sort()

