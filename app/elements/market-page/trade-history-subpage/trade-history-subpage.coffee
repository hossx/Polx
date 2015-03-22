'use strict'

# records are an array of {timestamp, isSell, price, quantity, total, typeClass, typeLabel}
Polymer 'trade-history-subpage',
  ready: () ->
    @M = window.M['market']['trades']

  formatTime: (t) ->
    moment(t).format("MM/DD-hh:mm:ss")

  loadMore: () ->
    this.$.ajax.loadMore()