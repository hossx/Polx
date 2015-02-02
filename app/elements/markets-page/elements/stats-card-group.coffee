'use strict'

Polymer 'stats-card-group',
  msgMap:
    'en':
      markets: " Markets"
      refresh: "Refreshed every %s seconds"

    'zh':
      markets: "市场"
      refresh: "每%s秒刷新一次"


  tickers: null
  
  ready: () ->
    @M = @msgMap[window.lang]
    @refreshInterval = window.config.refreshIntervals.tickers
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, @refreshInterval)

  tickersChanged: (o, n) ->
    if @tickers
      @marketIds = Object.keys(@tickers).sort()

  refreshFormatter: (v) -> @msgMap[window.lang].refresh.format(v/1000)