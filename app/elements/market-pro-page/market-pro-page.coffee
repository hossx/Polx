'use strict'

Polymer 'market-pro-page',
  msgMap:
    'en':
      relaxMode: "More about this market"
      ticker: "Ticker"
      availableBalance: "Available Balance"
      transfers: "Deposit/Withdrawal Records"
      orderBook: "Order Book"
      priceChart: "Price Chart"
      depthChart: "Depth Chart"
      myOpenOrders: "Open Orders"
      myTrades: "My Trade History"
      tradeHistory: "Trade History"
      
      refreshTooltip: "Refresh"
      refreshingMsg: "Refreshing market data..."



    'zh':
      relaxMode: "查看更多该市场信息"
      ticker: "市场概况"
      availableBalance: "可用余额"
      transfers: "充提记录"
      orderBook: "现有订单"
      priceChart: "价格图表"
      depthChart: "深度图表"
      myOpenOrders: "我的挂单"
      myTrades: "我的成交"
      tradeHistory: '成交记录'

      refreshTooltip: "更新数据"
      refreshingMsg: "正在更新市场数据..."


  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    @addEventListener 'refresh-market-data', (e) ->
      work = () => @refresh()
      setTimeout(work, 3000)

  created: () ->
    work = () => @refresh()
    @autoRefresh = setTimeout(work, window.config.refreshIntervals.pro)

  forceRefresh: () ->
    @fire('display-message', {'message': @M.refreshingMsg})
    @refresh()

  refresh: () ->
    clearTimeout(@autoRefresh) if @autoRefresh
    this.$.refresh.setAttribute("disabled","")
    reenable = () => this.$.refresh.removeAttribute("disabled")
    setTimeout(reenable, 1000)

    this.$.ajaxTicker.go()
    this.$.ajaxKline.go()
    this.$.orderBookSection.go()
    this.$.tradeHistorySection.go()
    if window.profile
      this.$.myOrdersSection.go()
      this.$.myTradesSection.go()
      this.$.myBalanceSection.go()

    work = () => @refresh() 
    @autoRefresh = setTimeout(work, window.config.refreshIntervals.pro)

  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]

  smallupChanged: (o, n) -> console.log(@smallup)

  