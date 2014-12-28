'use strict'

Polymer
  active: false

  detached: () ->
    console.log "detached: trade-subpage"
    this.$.toppendingCard.stop()

  activeChanged: (o, n) ->
    console.log("active-subpage: trade-subpage")
    if n
      console.log(@market)
      this.$.toppendingCard.go(@market)
    else
      this.$.toppendingCard.stop()
