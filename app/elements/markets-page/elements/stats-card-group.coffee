'use strict'

Polymer 'stats-card-group',
  msgMap:
    'en':
      markets: "Markets"
      refresh: "Refreshed every %s seconds"

    'zh':
      markets: "市场"
      refresh: "每%s秒刷新一次"


  tickers: null
  
  ready: () ->
    @M = @msgMap[window.lang]
    work = () =>this.$.ajax.go()
    @refreshInterval = window.config.refreshIntervals.tickers
    @refreshJob = setInterval(work, @refreshInterval)

  tickersChanged: (o, n) ->
    @marketIds = Object.keys(@tickers).sort()

  refreshFormatter: (v) -> @msgMap[window.lang].refresh.format(v)