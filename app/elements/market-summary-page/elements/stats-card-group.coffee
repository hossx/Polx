'use strict'

Polymer 'stats-card-group',
  ready: () ->
    @tickerUrl = window.protocol.tickerUrl(@currency.id)
    @tickers = []
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, window.config.refreshIntervals.tickers)
    console.debug("start auto-refresh for tickers " +  @tickerUrl)

  responseChanged: (o, n) ->
    if @response
      @tickers = @response.data
    else if @response == ''
      @stopRefresh()
      this.$.errorToast.show()

  detached: () ->
    @stopRefresh()
    
  errorChanged: (o, e) ->
    console.error("error: " + e) if e
    this.$.errorToast.show()

  stopRefresh: () ->
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.debug("stop auto-refresh for tickers")

    