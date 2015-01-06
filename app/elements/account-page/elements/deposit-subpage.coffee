'use strict'

Polymer 'deposit-subpage',
  currencyId: ''
  currencyKeys: []
  currency: null

  ready: () ->
    @config = window.config
    @currencyKeys = Object.keys(@config.currencies)

  currencyIdChanged: (o, n) ->
    console.log(@currencyId)
    @currency = @config.currencies[@currencyId]

