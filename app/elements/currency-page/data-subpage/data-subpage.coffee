'use strict'

Polymer 'data-subpage',
  currency: null
  txsUrl: ''
  snapshotUrl: ''
  hasMoreTxs: false
  hasMoreSnapshots: false

  ready: () ->
    @transactions = []
    @snapshots = []

  currencyChanged: (o, n) ->
      @txsUrl = window.protocol.cryptoTxsUrl(@currency.id)
      @snapshotUrl = window.protocol.reserveSnapshotsUrl(@currency.id)

  handleTxsComplete: (e, detail, sender) ->
    xhr = detail.xhr
    if xhr and xhr.status != 200 or not xhr.response
      @fire('network-error', {'url': @txsUrl})
    else
      resp = JSON.parse(xhr.response)
      @hasMoreTxs = resp.hasMore
      @transactions.push resp.txs...

  handleSnapshotsComplete: (e, detail, sender) ->
    xhr = detail.xhr
    if xhr and xhr.status != 200 or not xhr.response
      @fire('network-error', {'url': @snapshotUrl})
    else 
      resp = JSON.parse(xhr.response)
      @hasMoreSnapshots = resp.hasMore
      @snapshots.push resp.snapshots...

  loadMoreTxs: () -> this.$.txsAjax.go() if @hasMoreTxs
  loadMoreSnapshots: () -> this.$.snapshotAjax.go() if @hasMoreSnapshots

  ## TODO(dongw)
  formatAddrUrl: (value) -> "http://addr/" + value
  formatTxUrl: (value) -> "http://aaaaa/" + value
  formatUserUrl: (value) -> "/#/user/" + value
  formatFileUrl: (value) -> "file:" + value