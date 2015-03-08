'use strict'

Polymer 'market-pro-page',
  msgMap:
    'en':
      relaxMode: "More about this market"
      ticker: "Ticker"
      availableBalance: "Available Balance"
      news: "Market News"
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
      news: "市场新闻"
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

    # every 30 seconds, increase the refresh interval by 20%, max 5 minutes.
    @autoDelayRefresh = setInterval ()=>
      @refreshInterval = Math.min(Math.round(@refreshInterval  * 1.2), 300000)
    , 30000

  detached: () ->
    clearTimeout(@autoRefresh)
    clearInterval(@autoDelayRefresh)

  forceRefresh: () ->
    @fire('display-message', {'message': @M.refreshingMsg})
    @refresh()

  refresh: () ->
    clearTimeout(@autoRefresh)
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
    @autoRefresh = setTimeout(work, @refreshInterval)

  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]





  