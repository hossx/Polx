'use strict'

Polymer 'currency-page',
  page: 0

  ready: () ->
    @M = window.M['currency']['currency']
    @buttons = [['info', @M.about], ['verified-user', @M.reserves], ['cloud-download', @M.history]]
    @currencyId = ''
    @currency = null
    @config = window.config


  currencyIdChanged: (o, n) ->
    @currency = @config.currencies[@currencyId]

  detached: () ->
    console.debug "detached: detached"