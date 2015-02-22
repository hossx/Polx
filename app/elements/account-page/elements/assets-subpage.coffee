'use strict'

Polymer 'assets-subpage',
  msgMap:
    'en':
      assets: "Assets"
      currency: "Currency"
      total: "Total"
      available: "Available"
      locked: "Locked"
      pendingWithdrawal: "Pending Withdrawal"
      trade: "Trade "
      deposit: "Deposit "
      withdraw: "Withdraw "

    'zh':
      assets: "资产"
      currency: "货币"
      total: "总额"
      available: "可用金额"
      locked: "锁定金额"
      pendingWithdrawal: "等待提现金额"
      trade: "买卖"
      deposit: "充值"
      withdraw: "提现"


  ready: () ->
    @M = @msgMap[window.lang]
    @marketsFor = window.config.marketsForCurrency


  currentCollapse: null

  openMarkets: (e, detail, sender) -> 
    id = sender.getAttribute("id")
    collapse = document.querySelectorAll('section-group /deep/ #' + id + "markets")[0]
    
    if collapse
      if @currentCollapse
        @currentCollapse.toggle() 
      if @currentCollapse != collapse
        @currentCollapse = collapse
        @currentCollapse.toggle()
      else
        @currentCollapse = null

  gotoDeposit: (e, detail, sender) ->
    window.state.currencyId = sender.getAttribute("currencyId")
    @page = "deposit"


  gotoWithdraw: (e, detail, sender) ->
    window.state.currencyId = sender.getAttribute("currencyId")
    @page = "withdraw"


  balanceChanged: (o, n) ->
    currencyMap = window.config.currencies
    currencyKeys = Object.keys(currencyMap).sort()
    list = []

    for c in currencyKeys
      item = {
        currency: currencyMap[c]
      }
      if @balance[c]
        item.available = @balance[c][0]
        item.locked = @balance[c][1]
        item.pending = @balance[c][2]
        item.total = @balance[c][3]
      else
        item.available = 0
        item.locked = 0
        item.pending = 0
        item.total = 0
      list.push item

    @assets = list
