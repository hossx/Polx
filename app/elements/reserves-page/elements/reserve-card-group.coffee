'use strict'

Polymer 'reserve-card-group',
  ready: () ->
    @reserveStatsUrl = window.protocol.reserveStatsUrl()
    @reserves = {}
    @currencieIds = []
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, window.config.refreshIntervals.reserves)
    console.debug("start auto-refresh for reserves " +  @reserveStatsUrl)

  responseChanged: (o, n) ->
    if @response
      @reserves = @response.data
      @currencieIds = Object.keys(@reserves)
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

    