'use strict'

Polymer 'section-trade-history',
  ready: () ->
    @M = window.M['market-pro']['trades']

  go: () ->
    this.$.ajax.go()

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")