'use strict'

Polymer 'stats-card-group',
  ready: () ->
    @config = window.config
    @tickerUrl = window.protocol.tickerUrl(@currency.id)
    @tickers = []
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, @config.refreshIntervals.tickers)
    console.debug("start auto-refresh for tickers " +  @tickerUrl)

  responseChanged: (o, n) ->
    if @response
      @tickers = @response.data.sort (a, b) -> # TODO 
        if a.c < b.c
          -1
        else
          1
      console.debug(@tickers)
    else if @response == ''
      @stopRefresh()
      @fire("network-error", {'url': @tickerUrl})

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

    