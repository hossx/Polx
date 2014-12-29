'use strict'

Polymer 'market-summary-page',
  ready: () ->
    @config = window.config
    @marketGroupKeys = Object.keys(@config.marketGroups)

  detached: () ->
    console.log "detached: market-summary-page"
