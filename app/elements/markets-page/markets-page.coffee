'use strict'

Polymer 'markets-page',
  ready: () ->
    @config = window.config
    @marketGroupKeys = Object.keys(@config.marketGroups)

  detached: () ->
    console.log "detached: markets-page"
