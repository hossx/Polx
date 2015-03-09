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
      withdrawalDesc: "The minimum amount of withdrawal should equal or greater than %s %s, which include %s, as fee you have to pay. Any withdrawal request will be processed in 24 hours. Our working hours are between 12:00 and 24:00 in HongKong Time."
      identityVerifyRequirement: "Need identity verification to withdraw CNY"
      identityVerify: "Identity verify"
      withdrawalHint1: "The minimum amount for withdraw is: %s"
      withdrawalHint2: "Withdrawal fee: %s"
      withdrawalHint3: "Manual processing of %s is only available between 10:00AM and 10:00PM Beijing Time."
      withdrawalHint4: "We nomally process your requests within 1 hour."
      withdrawalHintBtsx: "Due to BTSX's API, now only support registered ID(Eg. coinport-deposit) to withdraw."

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
        6: "区块链重组中"
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
      withdrawalDesc: "最小提现不能小于 %s %s，无最大数量限制。 我们会从提现数目中扣除 %s作为手续费。提现请求会在24小时内处理完成。我们的工作时间是香港时间12:00-24:00，周末无休。如有其他问题，请联系客服人员。"
      identityVerifyRequirement: "根据相关政策，您需要进行实名认证才能够提现人民币。"
      identityVerify: "实名认证"
      withdrawalHint1: "每次提现的最小金额为: %s %s"
      withdrawalHint2: "提现手续费: %s"
      withdrawalHint3: "%s提现需要人工处理，我们的服务时间是北京时间早10点到晚10点。"
      withdrawalHint4: "您的提现一般会在一个小时内被处理。"
      withdrawalHintBtsx: "BTSX目前只支持使用已注册的帐号提币（比如coinport-deposit）。"

  feeMap:
    'en':
        'CNY':
            'l': 2
            'f': "0.4% (at least 2 CNY)"
        'BTC':
            'l': 0.01
            'f': "0.0005 BTC"
        'LTC':
            "l": 0.01
            "f": "0.0005 LTC"
        'DOGE':
            "l": 5
            "f": "2 DOGE"
        'BC':
            "l": 0.01
            "f": "0.0005 BC"
        'DRK':
            "l": 0.01
            "f": "0.0005 DRK"
        'VRC':
            "l": 0.01
            "f": "0.0005 VRC"
        'ZET':
            "l": 0.01
            "f": "0.0005 ZET"
        'BTSX':
            "l": 10
            "f": "2 BTSX"
        'NXT':
            "l": 10
            "f": "2 NXT"
        'XRP':
            "l": 10
            "f": "1 XRP"
        'GOOC':
            "l": 1000
            "f": "0 GOOC"
    'zh':
        'CNY':
            'l': 2
            'f': "0.4% (最小2元)"
        'BTC':
            'l': 0.01
            'f': "0.0005 BTC"
        'LTC':
            "l": 0.01
            "f": "0.0005 LTC"
        'DOGE':
            "l": 5
            "f": "2 DOGE"
        'BC':
            "l": 0.01
            "f": "0.0005 BC"
        'DRK':
            "l": 0.01
            "f": "0.0005 DRK"
        'VRC':
            "l": 0.01
            "f": "0.0005 VRC"
        'ZET':
            "l": 0.01
            "f": "0.0005 ZET"
        'BTSX':
            "l": 10
            "f": "2 BTSX"
        'NXT':
            "l": 10
            "f": "2 NXT"
        'XRP':
            "l": 10
            "f": "1 XRP"
        'GOOC':
            "l": 1000
            "f": "0 GOOC"

  selectedBalance: 0

  created: () ->
    @M = @msgMap[window.lang]
    @fee = @feeMap[window.lang]
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
        @selectedBalance = @balance[@currencyId][0]
      else
        @selectedBalance = 0
    else
      @selectedBalance = 0

  formatTime: (t) -> moment(t).format("YYYY/MM/DD-hh:mm")

  loadMore: () ->
    this.$.withdrawalsAjax.loadMore()

  genWithdrawalDesc: (currency) ->
    if !currency
      currency = 'BTC'
    @M.withdrawalDesc.format(@fee[currency]['l'], currency, @fee[currency]['f'])

  getWithdrawalLimit: (currency) ->
    if !currency
      currency = 'BTC'
    @feeMap[window.lang][currency]['l']

  onWithdrawSucceed: (e) ->
      this.$.withdrawalsAjax.go()

  genMessage: (format, content) ->
      format.format.apply(format, content)
