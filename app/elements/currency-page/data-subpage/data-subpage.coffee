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
      operationsLabel:
        0: "Deposit"
        1: "Withdrawal"

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
      operationsLabel:
        0: "提现"
        1: "充值"

  formatTransactionsComment: (v) -> @msgMap[window.lang].formatTransactionsComment.format(v)
  formatDistributionSnapshotsComment: (v) -> @msgMap[window.lang].formatDistributionSnapshotsComment.format(v)

  ready: () ->
    @M = @msgMap[window.lang]

  loadMoreTxs: () -> this.$.ajax1.loadMore()
  loadMoreSnapshots: () -> this.$.ajax2.loadMore()
  
  formatTime: (t) -> moment(t).format("MM/DD-hh:mm:ss")
  formatClass: (t) -> if t == 0 then "withdraw" else "deposit"