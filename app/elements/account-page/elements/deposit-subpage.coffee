'use strict'

Polymer 'deposit-subpage',
  msgMap:
    'en':
      id: "ID"
      address: "Address"
      transaction: "Transaction"
      quantity: "Quantity"
      timestamp: "Time"
      deposit: "Deposit"
      status: "Status"
      history: "Deposit Records"
      currencyToDeposit: "Currency to deposit: "
      scan: "Your wallet may support scaning of the following QR-Code:"
      statusLabels:
        0: "Pending"
        1: "Processing"
        2: "Confirming"
        3: "Cancelled"
        4: "Succeeded"
        5: "Failed"

    'zh':
      id: "ID"
      address: "地址"
      transaction: "转账记录"
      quantity: "金额"
      timestamp: "时间"
      deposit: "充值"
      status: "状态"
      history: "充值记录"
      currencyToDeposit: "充值货币： "
      scan: "如果钱包支持，您可以用钱包扫描下面二维码："
      statusLabels:
        0: "等待中"
        1: "处理中"
        2: "确认中"
        3: "已取消"
        4: "已完成"
        5: "已失败"

  depositAddress: ''
  addresses: {}
  nxtAddressComponents: []

  created: () ->
    @M = @msgMap[window.lang]
    @lang = window.lang
    @profile = window.profile
    @config = window.config
    @currencyKeys = Object.keys(@config.currencies).sort()

    #this.$.newAddressAjax.createAddress('BTC')

  currencyIdChanged: (o, n) ->
    @deposits = []
    if @currencyId
      @currency = @config.currencies[@currencyId]
      @updateDepositAddress()

  addressesChanged: (o, n) ->
    @updateDepositAddress()


  formatTime: (t) -> moment(t).format("YYYY/MM/DD-hh:mm")

  loadMore: () ->
    this.$.depositsAjax.loadMore()

  updateDepositAddress: () ->
    if @currencyId and @addresses and @addresses[@currencyId] and @addresses[@currencyId].length > 0
      @depositAddress = @addresses[@currencyId]

      if @currencyId == 'NXT'
        @nxtAddressComponents = @depositAddress.split("//")
    else
      @depositAddress = ''