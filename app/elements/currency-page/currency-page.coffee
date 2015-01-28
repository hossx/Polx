'use strict'

Polymer 'currency-page',
  msgMap:
    'en':
      about: "about"
      reserves: "Reserves"
      history: "History Data"
    'zh':
      about: "关于"
      reserves: "保证金数据"
      history: "历史数据"

  page: 0

  ready: () ->
    @M = @msgMap[window.lang]
    @buttons = [['info', @M.about], ['verified-user', @M.reserves], ['cloud-download', @M.history]]
    @currencyId = ''
    @currency = null
    @config = window.config


  currencyIdChanged: (o, n) ->
    @currency = @config.currencies[@currencyId]
    if not @currency
      console.warn("no such currency: " + @currencyId)
      # TODO: redirect to 404 page
    else
      @buttons[0][1] = @M.about + @currency.name

  detached: () ->
    console.debug "detached: detached"