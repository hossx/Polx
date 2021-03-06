'use strict'

Polymer 'market-pro-page',
  loggedIn: true

  ready: () ->
    @M = window.M['market-pro']['market-pro']
    @config = window.config
    @addEventListener 'refresh-market-data', (e) ->
      work = () => @refresh()
      setTimeout(work, 3000)

    @addEventListener 'buy-clicked', (e) ->
      buy = e.detail.buy
      this.$.trade.initState(buy.price, buy.accumulated)

    @addEventListener 'sell-clicked', (e) ->
      sell = e.detail.sell
      this.$.trade.initState(sell.price, sell.accumulated)

  created: () ->
    @refreshInterval = window.config.refreshIntervals.pro
    work = () => @refresh()
    @autoRefresh = setTimeout(work)

  detached: () ->
    clearTimeout(@autoRefresh)

  forceRefresh: () ->
    @fire('display-message', {'message': @M.refreshingMsg})
    @refresh()

  refresh: () ->
    @loggedIn = if window.profile then true else false
    clearTimeout(@autoRefresh)
    this.$.refresh.setAttribute("disabled","")
    reenable = () => this.$.refresh.removeAttribute("disabled")
    setTimeout(reenable, 3000)
    this.$.ajaxTicker.go()
    this.$.ajaxKline.go()
    this.$.orderBookSection.go()
    this.$.tradeHistorySection.go()
    
    if window.profile
      this.$.myOrdersSection.go()
      this.$.myTradesSection.go()
      this.$.myBalanceSection.go()
    
    @refreshInterval = Math.min(Math.round(@refreshInterval  * 1.2), 300000)
    work = () => @refresh() 
    @autoRefresh = setTimeout(work, @refreshInterval)

  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]





  