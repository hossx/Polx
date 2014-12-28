'use strict'

Polymer
  marketId: ''
  tab: 0

  ready: () ->
    @market = window.config.markets[@marketId]

  detached: () ->
    console.log "detached: detached"

  marketIdChanged: (o, n) ->
    @market = window.config.markets[n]

  switchTabTo: (tab) -> @tab = tab
  switchTab0: () -> @switchTabTo(0)
  switchTab1: () -> @switchTabTo(1)
  switchTab2: () -> @switchTabTo(2)
  switchTab3: () -> @switchTabTo(3)
