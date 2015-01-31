'use strict'

Polymer 'currency-page',
  msgMap:
    'en':
      about: "About"
      reserves: "Reserve"
      history: "Data"
    'zh':
      about: "货币趋势"
      reserves: "准备金"
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

  detached: () ->
    console.debug "detached: detached"