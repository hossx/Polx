'use strict'

Polymer 'deposit-subpage',
  currencyId: ''
  currency: null

  ready: () ->
    @config = window.config
    @deposits = []
    @currencyKeys = Object.keys(window.config.currencies)
    @currency = window.config.currencies[@currencyId]
    if not @currency
      @currencyId = 'BTC'
      @currency = window.config.currencies[@currencyId]

    @depositsUrl = window.protocol.userDepositsUrl(@currencyId)

  currencyIdChanged: (o, n) ->
    @currency = window.config.currencies[@currencyId]
    if not @currency
      @currencyId = 'BTC'
      @currency = window.config.currencies[@currencyId]
    @deposits = []
    @depositsUrl = window.protocol.userDepositsUrl(@currencyId)
    console.log(@depositsUrl)

  depositsRespChanged: (o, n) ->
    if @depositsResp
      if @depositsResp == ''
        @fire('network-error', {'url': @depositsUrl})
      else
        @hasMore = @depositsResp.data.hasMore || false
        @deposits.push @depositsResp.data.deposits...

  loadMore: () -> this.$.depositsAjax.go() if @hasMore