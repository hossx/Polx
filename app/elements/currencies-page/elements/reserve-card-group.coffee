'use strict'

Polymer 'reserve-card-group',
  ready: () ->
    @M = window.M['currencies']['group']

  reserveStatsChanged: (o, n) ->
    if @reserveStats
      @currencieIds = Object.keys(@reserveStats).sort()

