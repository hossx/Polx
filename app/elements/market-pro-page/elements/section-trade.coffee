'use strict'

Polymer 'section-trade',
  ready: () ->
    @M = window.M['market-pro']['trade']


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

  orderToSubmit: null
  minBuyAmount: 0.01
  minSellAmount: 0.01

  observe: {
    buyPrice: 'updateBuyEnabled'
    buyQuantity: 'updateBuyEnabled'
    sellPrice: 'updateSellEnabled'
    sellQuantity: 'updateSellEnabled'
  }

  initState: (price, quantity) ->
    if @selected == 0
      @buyPrice = @committedBuyPrice = price
      max = (Math.floor(10000 * @baseBalance/price) / 10000).toFixed(4)
      @buyQuantity = @committedBuyQuantity = Math.min(quantity, max)
    else if @selected == 1
      @sellPrice = @committedSellPrice = price
      @sellQuantity = @committedSellQuantity = Math.min(quantity, @balance)

  marketChanged: (o, n) ->
    @minBuyAmount = @market.json.minBuyAmount if @market.json.minBuyAmount
    @minSellAmount = @market.json.minSellAmount if @market.json.minSellAmount

  updateBuyEnabled: () -> 
    total = @buyPrice * @buyQuantity
    @buyEnabled = @buyPrice > 0 and @buyQuantity >= @minBuyAmount and total <= @baseBalance

  updateSellEnabled: () -> 
    total = @sellPrice * @sellQuantity
    @sellEnabled = @sellPrice > 0 and @sellQuantity >= @minSellAmount and @sellQuantity <= @balance

  doSell: () ->
    @sellEnabled = false
    order = '{"operation":"sell","market":"%s","amount":%s,"price":%s}'
      .format(@market.id,@committedSellQuantity,@committedSellPrice)
    this.$.submitOrderAjax.submitOrder(order)

  doBuy: () ->
    @buyEnabled = false
    order = '{"operation":"buy","market":"%s","amount":%s,"price":%s}'
      .format(@market.id,@committedBuyQuantity,@committedBuyPrice)
    this.$.submitOrderAjax.submitOrder(order)

  resultsChanged: (o, n) ->
    if @results
      if @results.length > 0
        result = @results[0]
        if not result.code or result.code == 0
          @fire('display-message', {message: @M.submittedMsg.format(@results[0].order_id)})
          @fire('refresh-market-data') 
        else
          @fire('display-message', {error: @M.submitionFailedMsg + '  - ' + result.code + ": " + (@M.errorCode[result.code.toString()] or @M.errorUnknown)})
    else
      @fire('display-message', {error: @M.submitionFailedMsg})

