'use strict'

Polymer 'external-stats-card-group',
  ready: () ->
    @M = window.M['markets']['x-group']

    @refreshInterval = window.config.refreshIntervals.tickers
    work = () => this.$.ajax.go()
    @refreshJob = setInterval(work, @refreshInterval)

  refreshFormatter: (v) -> if @M then @M.refresh.format(v/1000)

  detached: () ->
    clearInterval(@refreshJob)