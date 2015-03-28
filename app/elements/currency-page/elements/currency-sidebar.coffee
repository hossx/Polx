'use strict'

Polymer 'currency-sidebar',
  ready: ()-> 
    @M = window.M['currency']['sidebar']
    @config = window.config
    @currencyGroupKeys = Object.keys(window.config.currencyGroups)
    @currencyId = ''
    @currency = null
    @selectedGroup = ''

  currencyIdChanged: (o, n) ->
    @currency = @config.currencies[@currencyId]
    if @currency
      @selectedGroup = @currency.group

  groupLabel: (x) -> @M[x]