'use strict'

Polymer 'trade-subpage',
  active: false
  market: null
  cardIndex: 0

  created: () ->
    @refreshJob = null
    @bids = []
    @asks = []

  detached: () ->
    @stopRefresh()
    console.debug "detached: toppending-card"
    
  errorChanged: (o, e) ->
    console.error("error: " + e) if e

  responseChanged: (o, n) ->
    if @response == ''
      @fire('network-error', {'url': @depthUrl})
    else if @response and @response.success
      @bids = @response.data["b"] 
      @asks = @response.data["a"] 

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
    work = () =>this.$.depthAjax.go()
    @refreshJob = setInterval(work, @market.refreshInterval)
    work()
    console.debug("start auto-refresh market " +  @market.id + " every " + @market.refreshInterval + "ms: " + @depthUrl)

  stopRefresh: () ->
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.debug("stop auto-refresh market " +  @market.id)