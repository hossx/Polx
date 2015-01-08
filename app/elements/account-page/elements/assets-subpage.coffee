'use strict'

Polymer 'assets-subpage',
  assetsUrl: ''
  assetsResp: null
  assets: null
  currentCollapse: null

  ready: () ->
    @assetsUrl = window.protocol.userAssetsUrl
    @marketsFor = window.config.marketsForCurrency

  assetsRespChanged: (o, n) ->
    if @assetsResp and @assetsResp.code == 0
       @assets = @assetsResp.data
       @currencies = (window.config.currencies[k] for k in Object.keys(@assets).sort())

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

