'use strict'

Polymer 'cp-toolbar',
  msgMap:
    'en':
      coinport: "coinport"
      markets: "Markets"
      currencies: "Currencies"
      myAccount: "Account"

    'zh':
      coinport: "币丰港"
      markets: "市场"
      currencies: "货币"
      myAccount: "账号"

  ready: () ->
    @M = @msgMap[window.lang]

