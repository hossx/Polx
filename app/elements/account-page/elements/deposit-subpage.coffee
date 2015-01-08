'use strict'

Polymer 'deposit-subpage',
  currency: null
  address: 'afafaa'

  ready: () ->
    @config = window.config
    @deposits = []
    @currencyKeys = Object.keys(window.config.currencies)
    @currencyId = window.state.currencyId
    @currency = window.config.currencies[@currencyId]
    @depositsUrl = window.protocol.userDepositsUrl(@currencyId)

  currencyIdChanged: (o, n) ->
    if @page == "deposit"
      window.state.currencyId = @currencyId
      @currency = window.config.currencies[window.state.currencyId]
      @deposits = []
      @depositsUrl = window.protocol.userDepositsUrl(@currencyId)

  pageChanged: (o, n) ->
    if @page == "deposit"
      @currencyId = window.state.currencyId
      @currency = window.config.currencies[window.state.currencyId]
      @deposits = []
      @depositsUrl = window.protocol.userDepositsUrl(@currencyId)

  depositsRespChanged: (o, n) ->
    if @depositsResp
      if @depositsResp == ''
        @fire('network-error', {'url': @depositsUrl})
      else
        @hasMore = @depositsResp.data.hasMore || false
        @deposits.push @depositsResp.data.deposits...

  loadMore: () -> this.$.depositsAjax.go() if @hasMore