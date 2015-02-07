'use strict'

Polymer 'section-trade',
  msgMap:
    'en':
      sellAction: "Sell"
      buyAction: "Buy"
      price: "Price"
      quantity: "Quantity"
      total: "Total"

    'zh':
      sellAction: "买入"
      buyAction: "卖出"
      price: "价格"
      quantity: "数量"
      total: "总金额"

  ready: () ->
    @M = @msgMap[window.lang]

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