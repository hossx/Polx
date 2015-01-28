'use strict'

# records are an array of {timestamp, isSell, price, quantity, total, typeClass, typeLabel}
Polymer 'recent-txs-subpage',
  msgMap:
    'en':
      chart: "Taker Type Chart"
      tradeHistory: 'Trade History'
      index: "Index"
      takerOrderType: "Taker Order Type"
      price: "Price"
      quantity: "Quantity"
      total: "Total"
      sell: "Sell"
      buy: "Buy"

    'zh':
      chart: "触发类型图"
      tradeHistory: '成交记录'
      index: "序号"
      takerOrderType: "触发单类型"
      price: "价格"
      quantity: "数量"
      total: "成交额"
      sell: "卖单"
      buy: "买单"


  ready: () ->
    @M = @msgMap[window.lang]

  active: false
  market: null
  transactionsUrl: ''

  created: () ->
    @size = window.config.viewParams.market.tradingRecordInitialSize
    @records = []

    
  activeChanged: (o, n) ->
    if @active and @market
      @transactionsUrl = window.protocol.transactionsUrl(@market.id, @size)

  marketChanged: (o, n) ->
    if @active and @market
      @transactionsUrl = window.protocol.transactionsUrl(@market.id, @size)

  responseChanged: (o, n) ->
    if @response == ''
      @fire('network-error', {'url': @transactionsUrl})
    else if @response and @response.success
      records = ({
        timestamp: item.timestamp
        isSell: item.sell
        price: item.price.value
        quantity: item.subjectAmount.value
        total: item.currencyAmount.value} for item in @response.data.items)
      for record in records
          if record.isSell
            record.typeClass= "sell"
            record.typeLabel= @M.sell
          else
            record.typeClass= "buy"
            record.typeLabel= @M.buy

      setTimeout ()=>
        @records = records
      ,400