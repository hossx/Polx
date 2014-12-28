'use strict'

Polymer
  created: () ->
    @bids = @asks = []
    @market = null
    @needStartRefresh = false
    @refreshJob = null

  detached: () ->
    @cancelUnbindAll()
    @stop()
    console.log "detached: toppending-card"
    
  errorChanged: (o, e) ->
    console.log("error: " + e) if e

  responseChanged: (o, r) ->
    if r and r.success
      console.log(r)
      @bids = r.data["b"] if @bids != r.data["b"]
      @asks = r.data["a"] if @asks != r.data["a"]
    else
      @bids = @asks = []

  marketChanged: (o, m) ->
    if m and m != o
      @depthUrl = window.protocol.depthUrl(m.id)
      @startRefresh()


  go: () =>
    if @market
      @startRefresh()
    else
      @needStartRefresh = true

  startRefresh: () ->
    # both @needStartRefresh and @market are not null
    @stop()
    work = () =>this.$.ajax.go()
    @refreshJob = setInterval(work, @market.refreshInterval)
    console.log("start auto-refresh market " +  @market.id + " every " + @market.refreshInterval + "ms")

  stop: () ->
    @needStartRefresh = false
    if @refreshJob
      clearInterval(@refreshJob)
      @refreshJob = null
      console.log("stop auto-refresh market " +  @market.id)

    