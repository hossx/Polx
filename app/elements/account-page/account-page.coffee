'use strict'

Polymer 'account-page',
  msgMap:
    'en':
      myAccount: "My Account"
      tradeTooltip: "Trade Now"

    'zh':
      myAccount: "我的账号"
      tradeTooltip: "交易"

  page: "orders"
  currencyId: 'BTC'

  ready: () ->
    @M = @msgMap[window.lang]