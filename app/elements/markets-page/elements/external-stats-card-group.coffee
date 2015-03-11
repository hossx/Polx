'use strict'

Polymer 'external-stats-card-group',
  msgMap:
    'en':
      markets: "External BTC/CNY Markets"
      refresh: "Refreshed every %s seconds"

    'zh':
      markets: "第三方BTC/CNY市场"
      refresh: "每%s秒刷新一次"

  ready: () ->
    @M = @msgMap[window.lang]

    @refreshInterval = window.config.refreshIntervals.tickers
    work = () =>
      this.$.ajax.go()
    @refreshJob = setInterval(work, @refreshInterval)

  refreshFormatter: (v) -> @msgMap[window.lang].refresh.format(v/1000)