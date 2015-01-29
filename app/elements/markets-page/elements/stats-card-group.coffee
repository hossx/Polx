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


  ready: () ->
    @M = @msgMap[window.lang]
    console.log(@M.markets)
    @config = window.config
    @tickerUrl = window.protocol.tickerUrl(@currency.id)
    @tickers = null
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, @config.refreshIntervals.tickers)
    console.debug("start auto-refresh for tickers " +  @tickerUrl)

  responseChanged: (o, n) ->
    if @response
      if @response == ''
        @stopRefresh()
        @fire("network-error", {'url': @tickerUrl})
      else
        @tickers = @response.data.sort (a, b) -> # TODO 
          if a.c < b.c
            -1
          else
            1

  detached: () ->
    @stopRefresh()
    
  errorChanged: (o, e) ->
    console.error("error: " + e) if e
    @fire("network-error", {'url': @tickerUrl})

  stopRefresh: () ->
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.debug("stop auto-refresh for tickers")

