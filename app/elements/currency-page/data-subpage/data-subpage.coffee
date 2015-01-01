'use strict'

Polymer 'data-subpage',
  currency: null
  txsUrl: ''
  response: ''
  hasMore: false

  snapshotResponse: ''
  hasMoreSnapshots: false

  ready: () ->
    @transactions = []
    @snapshots = []

  currencyChanged: (o, n) ->
      @txsUrl = window.protocol.currencyTxsUrl(@currency.id)
      @snapshotUrl = window.protocol.currencySnapshotsUrl(@currency.id)

  responseChanged: (o, n) ->
    if @response
      if @response == ''
        @fire('network-error', {'url': @currencyTxsUrl})
      else
        @hasMore = @response.hasMore
        @transactions.push @response.txs...

  snapshotResponseChanged: (o, n) ->
    if @snapshotResponse
      if @snapshotResponse == ''
        @fire('network-error', {'url': @snapshotUrl})
      else
        @hasMoreSnapshots = @snapshotResponse.hasMore
        @snapshots.push @snapshotResponse.snapshots...

  loadMoreTxs: () -> this.$.txsAjax.go() if @hasMore
  loadMoreSnapshots: () -> this.$.snapshotAjax.go() if @hasMoreSnapshots

  ## TODO(dongw)
  formatAddrUrl: (value) -> "http://addr/" + value
  formatTxUrl: (value) -> "http://aaaaa/" + value
  formatUserUrl: (value) -> "/#/user/" + value

  formatFileUrl: (value) -> "file:" + value