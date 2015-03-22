'use strict'

Polymer 'load-data-widget',
  ready: () ->
    @M = window.M['utils']['load-data-widget']

  loadMore: () ->
    @fire("load-more")