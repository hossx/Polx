'use strict'

Polymer 'stats-card-group',
  msgMap:
    'en':
      markets: "Markets"
      refresh: "Refreshed every %s seconds"

    'zh':
      markets: "市场"
      refresh: "每%s秒刷新一次"

  refreshFormatter: (v) -> @msgMap[window.lang].refresh.format(v)


  tickers: null
  ready: () ->
    @M = @msgMap[window.lang]
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, window.config.refreshIntervals.tickers)

  tickersChanged: (o, n) ->
    @marketIds = Object.keys(@tickers).sort()