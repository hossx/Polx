'use strict'

Polymer 'reserve-card-group',
  msgMap:
    'en':
      reserveStats: "Currency Reserves"
      refresh: "Refersh every %s seconds"

    'zh':
      reserveStats: "货币准备金统计"
      refresh: "每%s秒刷新一次"

  refreshFormatter: (v) -> @msgMap[window.lang].refresh.format(v)


  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    @reserveStatsUrl = window.protocol.reserveStatsUrl()
    @reserves = {}
    @currencieIds = []
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, @config.refreshIntervals.reserves)
    console.debug("start auto-refresh for reserves " +  @reserveStatsUrl)

  responseChanged: (o, n) ->
    if @response
      @reserves = @response.data
      @currencieIds = Object.keys(@reserves).sort()
    else if @response == ''
      @stopRefresh()
      @fire("network-error", {'url': @reserveStatsUrl})

  detached: () ->
    @stopRefresh()
    
  errorChanged: (o, e) ->
    console.error("error: " + e) if e
    @fire("network-error", {'url': @reserveStatsUrl})

  stopRefresh: () ->
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.debug("stop auto-refresh for reserves")

    