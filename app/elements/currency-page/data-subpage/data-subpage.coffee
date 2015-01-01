'use strict'

Polymer 'data-subpage',
  currency: null
  txsUrl: ''
  response: ''
  hasMore: false

  ready: () ->
    @transactions = []

  currencyChanged: (o, n) ->
      @txsUrl = window.protocol.currencyTxsUrl(@currency.id)

  responseChanged: (o, n) ->
    if @response
      if @response == ''
        @fire('network-error', {'url': @currencyTxsUrl})
      else
        @hasMore = @response.hasMore
        @transactions.push @response.txs...

  loadMore: () -> this.$.ajax.go() if @hasMore

  ## TODO(dongw)
  formatAddrUrl: (value) -> "http://addr/" + value
  formatTxUrl: (value) -> "http://aaaaa/" + value
  formatUserUrl: (value) -> "/#/user/" + value