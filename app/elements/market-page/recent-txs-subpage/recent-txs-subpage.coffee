'use strict'

# records are an array of {timestamp, isSell, price, quantity, total, typeClass, typeLabel}
Polymer 'recent-txs-subpage',
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
            record.typeLabel= "Sell"
          else
            record.typeClass= "buy"
            record.typeLabel= "Buy"

      @records = records