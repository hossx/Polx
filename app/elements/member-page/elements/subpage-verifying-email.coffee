'use strict'

Polymer 'subpage-verifying-email',
  loading: true

  ready: () ->
    @M = window.M['member']['verify-email']

  tokenChanged: (o, n) ->
    this.$.ajax.verify(@token) if @token
