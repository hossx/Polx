'use strict'

Polymer 'toppending-card',
  created: () ->
    @bids = @asks = []
    @market = null
    @active = false
    @refreshJob = null

  detached: () ->
    @stopRefresh()
    console.debug "detached: toppending-card"
    
  errorChanged: (o, e) ->
    console.error("error: " + e) if e

  responseChanged: (o, r) ->
    if r and r.success
      @bids = r.data["b"] if @bids != r.data["b"]
      @asks = r.data["a"] if @asks != r.data["a"]
    else
      @bids = @asks = []

  marketChanged: (o, n) ->
    @startRefresh() if @active and @market

  activeChanged: (o, n) ->
    if @active
      @startRefresh() if @market
    else
      @stopRefresh()

  startRefresh: () ->
    @stopRefresh()
    @depthUrl = window.protocol.depthUrl(@market.id)
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, @market.refreshInterval)
    console.debug("start auto-refresh market " +  @market.id + " every " + @market.refreshInterval + "ms: " + @depthUrl)

  stopRefresh: () ->
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.debug("stop auto-refresh market " +  @market.id)

    