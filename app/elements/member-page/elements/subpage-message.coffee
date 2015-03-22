'use strict'

Polymer 'subpage-message',
  label: ''
  details: []

  ready: () ->
    @M = window.M['member']['messages']

  msgChanged: (o, n) ->
    if @msg and @M[@msg]
      @label = @M[@msg].label
      @details = @M[@msg].details
