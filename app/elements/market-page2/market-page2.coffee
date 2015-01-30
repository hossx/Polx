'use strict'

Polymer 'market-page2',
  msgMap:
    'en':
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

    'zh':
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
      withdraw: "充值"
      deposit: "提现"
      relaxMode: "查看更多该市场信息"

  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    
    @bids = []
    @asks = []
    @bidsReverse = []
    @tradeHistory = []




  market: null
  orderBookUrl: ''

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
    if not @market
      console.warn("no such market: " + @marketId)
      # TODO: redirect to 404 page
    else
      #window.config.viewParams.market.orderBookInitialSize
      @orderBookUrl = window.protocol.depthUrl(@market.id, 30)
      @transactionsUrl = window.protocol.transactionsUrl(@market.id, 60)

  orderBookRespChanged: (o, n) ->
    if @orderBookResp == ''
      @fire('network-error', {'url': @orderBookUrl})

    else if @orderBookResp and @orderBookResp.success
      asks = []
      bids = []

      accumulated = 0
      for a in @orderBookResp.data.a
        accumulated = accumulated + a.av
        asks.push {price: a.pv, quantity: a.av, accumulated: accumulated}
      
      accumulated = 0
      for b in @orderBookResp.data.b
        accumulated = accumulated + b.av
        bids.push {price: b.pv, quantity: b.av, accumulated: accumulated}

      @asks = asks
      @bids = bids
      @bidsReverse = bids.slice().reverse()

  tradeHistoryRespChanged: (o, n) ->
    if @tradeHistoryResp == ''
      @fire('network-error', {'url': @transactionsUrl})
    else if @tradeHistoryResp and @tradeHistoryResp.success
      tradeHistory = ({
        timestamp: moment(item.timestamp).format("hh:mm:ss")
        class: if item.sell then "sell" else "buy"
        price: item.price.value
        quantity: item.subjectAmount.value
        total: item.currencyAmount.value} for item in @tradeHistoryResp.data.items)
      @tradeHistory = tradeHistory
