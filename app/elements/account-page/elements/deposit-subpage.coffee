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
      history: "Deposit Records"

    'zh':
      id: "ID"
      address: "地址"
      transaction: "转账记录"
      quantity: "金额"
      timestamp: "时间"
      deposit: "充值"
      history: "充值记录"


  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    @currencyKeys = Object.keys(@config.currencies)

  address: 'afafaa'

  currencyIdChanged: (o, n) ->
    @deposits = []
    if @currencyId
      @currency = @config.currencies[@currencyId]

  formatTime: (t) -> moment(t).format("MM/DD-hh:mm:ss")

  loadMore: () ->
    this.$.depositsAjax.loadMore()