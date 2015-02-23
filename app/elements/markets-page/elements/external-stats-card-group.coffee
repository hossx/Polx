'use strict'

Polymer 'external-stats-card-group',
  msgMap:
    'en':
      markets: "External BTC Markets"
      refresh: "Refreshed every %s seconds"

    'zh':
      markets: "站外比特币市场"
      refresh: "每%s秒刷新一次"


  tickers: null
  
  ready: () ->
    @M = @msgMap[window.lang]
    @refreshInterval = window.config.refreshIntervals.tickers
    work = () =>
      this.$.huobi.go()
    @refreshJob = setInterval(work, @refreshInterval)

  huobiTickerChanged: (o, n) ->
    console.log(@huobiTicker)

  refreshFormatter: (v) -> @msgMap[window.lang].refresh.format(v/1000)