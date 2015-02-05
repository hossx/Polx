'use strict'

Polymer 'market-pro-page',
  msgMap:
    'en':
      ticker: "Ticker"
      availableBalance: "Available Balance"
      transfers: "Deposit/Withdrawal Records"
      orderBook: "Order Book"
      priceChart: "Price Chart"
      depthChart: "Depth Chart"
      openOrders: "Open Orders"
      tradeHistory: "Trade History"
      buyOrders: "Buy Orders"
      sellOrders: "Sell Orders"
      price: "Price"
      quantity: "Quantity"
      accumulated: "Accumulated"
      time: "Time"
      sell: "Sell"
      buy: "Buy"
      sellAction: "Sell"
      buyAction: "Buy"
      withdraw: "Withdraw"
      deposit: "Deposit"
      relaxMode: "See more information"
      lastPrice: "Last Price"
      volume: "24H Volume"
      change: "24H Change"
      spread: "Spread"

    'zh':
      ticker: "市场概况"
      availableBalance: "可用余额"
      transfers: "充提记录"
      orderBook: "现有订单"
      priceChart: "价格图表"
      depthChart: "深度图表"
      openOrders: "我的挂单"
      tradeHistory: '成交记录'
      buyOrders: "买单"
      sellOrders: "卖单"
      price: "价格"
      quantity: "数量"
      accumulated: "累积数量"
      time: "时间"
      sell: "卖单"
      buy: "买单"
      sellAction: "买入"
      buyAction: "卖出"
      withdraw: "提现"
      deposit: "充值"
      relaxMode: "查看更多该市场信息"
      lastPrice: "最新成交价"
      volume: "24小时成交"
      change: "24小时价差"
      spread: "买卖价差"

  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    @tradeHistory = []

    work = () =>
      this.$.ajaxTicker.go()
      this.$.ajaxDepth.go()
      this.$.ajaxKline.go()
      this.$.ajaxTradeHistory.go()
      this.$.ajaxMyOrders.go()

    setInterval(work, window.config.refreshIntervals.pro)

  market: null

  buyPrice: 0.0
  committedBuyPrice: 0.0
  buyQuantity: 0.0
  committedBuyQuantity: 0.0
  buyEnabled: false

  sellPrice: 0.0
  committedSellPrice: 0.0
  sellQuantity: 0.0
  committedSellQuantity: 0.0
  sellEnabled: false

  observe: {
    buyPrice: 'updateBuyEnabled'
    buyQuantity: 'updateBuyEnabled'
    sellPrice: 'updateSellEnabled'
    sellQuantity: 'updateSellEnabled'
  }

  updateBuyEnabled: () ->
    @buyEnabled = @buyPrice > 0 and @buyQuantity > 0

  updateSellEnabled: () ->
    @sellEnabled = @sellPrice > 0 and @sellQuantity > 0

  marketIdChanged: (o, n) ->
    @market = @config.markets[@marketId]
