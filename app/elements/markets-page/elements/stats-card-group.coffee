'use strict'

Polymer 'stats-card-group',
  tickers: null
  
  ready: () ->
    @M = window.M['markets']['group']
    @refreshInterval = window.config.refreshIntervals.tickers
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, @refreshInterval)

  detached: () ->
    clearInterval(@refreshJob)

  tickersChanged: (o, n) ->
    if @tickers
      @marketIds = Object.keys(@tickers).sort()

  refreshFormatter: (v) -> if @M then @M.refresh.format(v/1000)