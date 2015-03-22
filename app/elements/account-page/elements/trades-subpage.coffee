'use strict'

Polymer 'trades-subpage',
  ready: () ->
    @M = window.M['account']['trades']
    @config = window.config

  formatTime: (t) ->
    moment(t).format("YYYY-MM/DD-hh:mm") 

  loadMore: () ->
    this.$.ajax.loadMore()