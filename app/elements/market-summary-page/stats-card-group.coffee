'use strict'

Polymer
  ready: () ->
    @tickerUrl = window.protocol.tickerUrl(@currency.id)
    @tickers = []
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, window.config.refreshIntervals.tickers)
    console.log("start auto-refresh for tickers " +  @tickerUrl)

  responseChanged: (o, n) ->
    @tickers = n.data if n

  detached: () ->
    @stopRefresh()
    console.log "detached: stats-card-group"
    
  errorChanged: (o, e) ->
    console.log("error: " + e) if e

  stopRefresh: () ->
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.log("stop auto-refresh for tickers")

    