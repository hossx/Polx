'use strict'

Polymer 'market-pro-page',
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
      lastPrice: "Last Price"
      volume: "24H Volume"
      change: "24H Change"
      spread: "Spread"

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
      withdraw: "提现"
      deposit: "充值"
      relaxMode: "查看更多该市场信息"
      lastPrice: "最新成交价"
      volume: "24小时总成交量"
      change: "24小时价格变化"
      spread: "买卖价差"

  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    
    @bids = []
    @asks = []
    @bidsReverse = []
    @tradeHistory = []
    @spread = 0


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
      @tickerUrl = window.protocol.tickerUrl(@market.id)
      @orderBookUrl = window.protocol.depthUrl(@market.id, 30)
      @tradeHistoryUrl = window.protocol.tradeHistoryUrl(@market.id, 60)

  tickerRespChanged: (o, n) ->
    if @tickerResp == ''
      @fire('network-error', {'url': @tickerUrl})
    else if @tickerResp
      @ticker = @tickerResp.data[@market.id]
      @priceChange = (100*@ticker[4]).toFixed(2)+"%"
      if @ticker[4] < 0
        @changeClass = "down"
      else if @ticker[4] > 0
        @changeClass = "up"
        @priceChange = "+" + @priceChange
      else
        @changeClass = ''


  orderBookRespChanged: (o, n) ->
    if @orderBookResp == ''
      @fire('network-error', {'url': @orderBookUrl})

    else if @orderBookResp and @orderBookResp.success
      asks = []
      bids = []

      accumulated = 0
      for ask in @orderBookResp.data.asks
        accumulated = accumulated + ask[1]
        asks.push {price: ask[0], quantity: ask[1], accumulated: accumulated}
      
      accumulated = 0
      for bid in @orderBookResp.data.bids
        accumulated = accumulated + bid[1]
        bids.push {price: bid[0], quantity: bid[1], accumulated: accumulated}

      @asks = asks
      @bids = bids
      @bidsReverse = bids.slice().reverse()
      @spread = 
        if @asks.length > 0 and @bids.length > 0
          @asks[0].price - @bids[0].price
        else
          0

  tradeHistoryRespChanged: (o, n) ->
    if @tradeHistoryResp
      if @tradeHistoryResp == ''
        @fire('network-error', {'url': @tradeHistoryUrl})
      else if @tradeHistoryResp.data
        tradeHistory = ({
          timestamp: moment(item.timestamp).format("hh:mm:ss")
          class: if item.isSell then "sell" else "buy"
          price: item.price
          quantity: item.amount
          total: item.amount * item.price} for item in @tradeHistoryResp.data.trades)
        @tradeHistory = tradeHistory
