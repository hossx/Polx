'use strict'

Polymer 'assets-subpage',
  ready: () ->
    @M = window.M['account']['assets']
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
    @fire("goto-account-subpage", {page: 'deposit', currencyId: sender.getAttribute("currencyId")})


  gotoWithdraw: (e, detail, sender) ->
   @fire("goto-account-subpage", {page: 'withdraw', currencyId: sender.getAttribute("currencyId")})

  groupLabel: (i) ->
    @M['assets'][(i or 0).toString()]

  balanceChanged: (o, n) ->
    currencyMap = window.config.currencies
    currencyKeys = Object.keys(currencyMap).sort()
    crypto = []
    nonCrypto = []

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

      if item.currency.isCrypto
        crypto.push item
      else 
        nonCrypto.push item
    @assetGroups = [nonCrypto, crypto]
