'use strict'

Polymer 'data-subpage',
  msgMap:
    'en':
      transactions: 'Transactions'
      formatTransactionsComment: "The following blockchain transactions involve our %s addresses."
      distributionSnapshots: "Distributation Snapshots"
      formatDistributionSnapshotsComment : "The following files capture our %s distribution among all our users at certain time."
      timestamp: "Timestamp"
      userId: "User ID"
      type: "Type"
      amount: "Amount"
      address: "Address"
      transaction: "Transaction"
      file: "File"
      size: "Size"

    'zh':
      transactions: '转账记录'
      formatTransactionsComment: "以下是与币丰港%s冷热钱包地址相关的区块链转账记录。"
      distributionSnapshots: "资产分布快照"
      formatDistributionSnapshotsComment : "下列文件存储了特定时刻%s资产在币丰港用户间的分布情况。"
      timestamp: "时间"
      userId: "用户ID"
      type: "类型"
      amount: "数量"
      address: "地址"
      transaction: "转账"
      file: "文件"
      size: "大小"

  formatTransactionsComment: (v) -> @msgMap[window.lang].formatTransactionsComment.format(v)
  formatDistributionSnapshotsComment: (v) -> @msgMap[window.lang].formatDistributionSnapshotsComment.format(v)


  currency: null
  txsUrl: ''
  snapshotUrl: ''
  hasMoreTxs: false
  hasMoreSnapshots: false

  ready: () ->
    @M = @msgMap[window.lang]
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