'use strict'

Polymer 'withdraw-subpage',
  msgMap:
    'en':
      na: "N/A"
      id: "ID"
      address: "Address"
      transaction: "Transaction"
      quantity: "Quantity"
      timestamp: "Time"
      withdraw: "withdraw"
      status: "Status"
      history: "withdraw Records"
      currencyToWithdraw: "Currency: "
      balance: "Balance:"
      scan: "Your wallet may support scaning of the following QR-Code:"
      statusLabels:
        0: "Pending"
        1: "Accepted"
        2: "Confirming"
        3: "Confirmed"
        4: "Succeeded"
        5: "Failed"
        6: "Re-organizing"
        7: "Re-org OK"
        8: "Cancelled"
        9: "Rejected"
        10: "Insufficient Hot Wallet"
        11: "Processing"
        12: "Internal Error"
        13: "Internal Error"
        14: "Internal Error"
        15: "Internal Error"
        16: "Internal Error"
        17: "Internal Error"

    'zh':
      na: "无"
      id: "ID"
      address: "地址"
      transaction: "转账记录"
      quantity: "金额"
      timestamp: "时间"
      withdraw: "提现"
      status: "状态"
      history: "提现记录"
      currencyToWithdraw: "货币： "
      balance: "余额："
      scan: "如果钱包支持，您可以用钱包扫描下面二维码："
      statusLabels:
        0: "等待中"
        1: "已提交"
        2: "确认中"
        3: "已确认"
        4: "已成功"
        5: "已失败"
        6: "区块链重重组"
        7: "区块链已重组"
        8: "已取消"
        9: "已被拒"
        10: "热钱包不足"
        11: "处理中"
        12: "系统错误"
        13: "系统错误"
        14: "系统错误"
        15: "系统错误"
        16: "系统错误"
        17: "系统错误"

  selectedBalance: 0

  created: () ->
    @M = @msgMap[window.lang]
    @lang = window.lang
    @profile = window.profile
    @config = window.config
    @currencyKeys = Object.keys(@config.currencies).sort()

    #this.$.newAddressAjax.createAddress('BTC')

  observe: {
    balance: 'onChange' 
  }

  currencyIdChanged: (o, n) ->
    @withdrawals = []
    if @currencyId
      @currency = @config.currencies[@currencyId]
      @onChange()

  onChange: () ->
    if @currencyId
      if @balance and @balance[@currencyId]
        @selectedBalance = @balance[@currencyId][3]
      else
        @selectedBalance = 0
    else
      @selectedBalance = 0

  formatTime: (t) -> moment(t).format("YYYY/MM/DD-hh:mm")

  loadMore: () ->
    this.$.withdrawalsAjax.loadMore()

