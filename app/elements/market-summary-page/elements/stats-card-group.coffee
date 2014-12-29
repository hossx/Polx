'use strict'

Polymer 'stats-card-group',
  ready: () ->
    @tickerUrl = window.protocol.tickerUrl(@currency.id)
    @tickers = []
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, window.config.refreshIntervals.tickers)
    console.log("start auto-refresh for tickers " +  @tickerUrl)
    this.$.errorToast.show()

  responseChanged: (o, n) ->
    if not n
      @stopRefresh()
      this.$.errorToast.show()
    else
      @tickers = n.data

  detached: () ->
    @stopRefresh()
    
  errorChanged: (o, e) ->
    console.log("error: " + e) if e
    this.$.errorToast.show()

  stopRefresh: () ->
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.log("stop auto-refresh for tickers")

    