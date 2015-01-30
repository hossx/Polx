'use strict'

Polymer 'market-page2',
  msgMap:
    'en':
      depthChart: "Depth Chart"
      orderBook: "Order Book"
      buyOrders: "Buy Orders"
      sellOrders: "Sell Orders"
      index: "Index"
      price: "Price"
      quantity: "Quantity"
      accumulated: "Accumulated"
      tradeHistory: 'Trade History'
      time: "Time"
      sell: "Sell"
      buy: "Buy"

    'zh':
      depthChart: "深度图"
      orderBook: "现有订单"
      buyOrders: "买单"
      sellOrders: "卖单"
      price: "价格"
      quantity: "数量"
      accumulated: "累计数量"
      tradeHistory: '成交记录'
      index: "序号"
      time: "时间"
      sell: "卖单"
      buy: "买单"

  ready: () ->
    @M = @msgMap[window.lang]
    @config = window.config
    
    @bids = []
    @asks = []
    @bidsReverse = []
    @tradeHistory = []


  market: null
  orderBookUrl: ''

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
