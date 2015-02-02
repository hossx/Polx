'use strict'

Polymer 'reserve-card-group',
  msgMap:
    'en':
      reserveStats: "Currency Reserves"
      refresh: "Refersh every %s seconds"

    'zh':
      reserveStats: "货币准备金"
      refresh: "每%s秒刷新一次"

  reserveStats: null

  ready: () ->
    @M = @msgMap[window.lang]
    @refreshInterval = window.config.refreshIntervals.reserves
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, window.config.refreshIntervals.reserves)

  reserveStatsChanged: (o, n) ->
    if @reserveStats
      @currencieIds = Object.keys(@reserveStats).sort()

  refreshFormatter: (v) -> @msgMap[window.lang].refresh.format(v/1000)
